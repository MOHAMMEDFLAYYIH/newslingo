-- ================================================
-- NewsLingo Schema v2 — Level-based content + translations
-- Run ALL in Supabase Dashboard > SQL Editor
-- ================================================

-- 0. Drop old stuff
DROP FUNCTION IF EXISTS public.insert_article;
DROP TABLE IF EXISTS public.bookmarks CASCADE;
DROP TABLE IF EXISTS public.articles CASCADE;

-- 1. Articles table with level-specific English content
CREATE TABLE IF NOT EXISTS articles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT 'general',
  source TEXT NOT NULL DEFAULT 'NewsLingo',
  image_url TEXT DEFAULT '',
  audio_url TEXT DEFAULT '',
  base_level TEXT DEFAULT 'B1',
  published_at TIMESTAMPTZ DEFAULT NOW(),
  -- English content for each CEFR level
  content_a1 TEXT DEFAULT '',
  content_a2 TEXT DEFAULT '',
  content_b1 TEXT DEFAULT '',
  content_b2 TEXT DEFAULT '',
  content_c1 TEXT DEFAULT '',
  -- English descriptions for each level
  description_a1 TEXT DEFAULT '',
  description_a2 TEXT DEFAULT '',
  description_b1 TEXT DEFAULT '',
  description_b2 TEXT DEFAULT '',
  description_c1 TEXT DEFAULT '',
  -- Extracted vocabulary
  vocabulary JSONB DEFAULT '[]'::jsonb
);

-- 2. Article translations (pre-translated via DeepL)
CREATE TABLE IF NOT EXISTS article_translations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  article_id UUID REFERENCES articles(id) ON DELETE CASCADE NOT NULL,
  language TEXT NOT NULL,
  level TEXT NOT NULL,
  title TEXT DEFAULT '',
  description TEXT DEFAULT '',
  content TEXT DEFAULT '',
  UNIQUE(article_id, language, level)
);

-- 3. User Profiles
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  name TEXT,
  email TEXT,
  avatar_url TEXT,
  level TEXT DEFAULT 'beginner',
  bio TEXT DEFAULT '',
  interests JSONB DEFAULT '[]'::jsonb,
  onboarding_complete BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Saved Words
CREATE TABLE IF NOT EXISTS saved_words (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  word TEXT NOT NULL,
  definition TEXT NOT NULL,
  translation TEXT,
  article_id UUID REFERENCES articles(id) ON DELETE SET NULL,
  part_of_speech TEXT DEFAULT '',
  saved_at TIMESTAMPTZ DEFAULT NOW(),
  review_count INT DEFAULT 0,
  next_review_date TIMESTAMPTZ,
  UNIQUE(user_id, word)
);

-- 5. Bookmarks
CREATE TABLE IF NOT EXISTS bookmarks (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  article_id UUID REFERENCES articles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (user_id, article_id)
);

-- 6. User Progress
CREATE TABLE IF NOT EXISTS user_progress (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  streak INT DEFAULT 0,
  articles_read INT DEFAULT 0,
  words_learned INT DEFAULT 0,
  quizzes_passed INT DEFAULT 0,
  last_active_date TIMESTAMPTZ
);

-- 7. User Settings
CREATE TABLE IF NOT EXISTS user_settings (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  language TEXT DEFAULT 'ar',
  notifications_enabled BOOLEAN DEFAULT true,
  daily_reminder BOOLEAN DEFAULT false,
  reminder_time TIME DEFAULT '09:00',
  dark_mode BOOLEAN DEFAULT false,
  sound_effects BOOLEAN DEFAULT true,
  auto_play_audio BOOLEAN DEFAULT false
);

-- 8. Insert article function (bypasses RLS via SECURITY DEFINER)
CREATE OR REPLACE FUNCTION public.insert_article(
  p_title TEXT,
  p_description TEXT,
  p_category TEXT,
  p_source TEXT,
  p_image_url TEXT,
  p_audio_url TEXT,
  p_base_level TEXT,
  p_published_at TIMESTAMPTZ,
  p_content_a1 TEXT DEFAULT '',
  p_content_a2 TEXT DEFAULT '',
  p_content_b1 TEXT DEFAULT '',
  p_content_b2 TEXT DEFAULT '',
  p_content_c1 TEXT DEFAULT '',
  p_description_a1 TEXT DEFAULT '',
  p_description_a2 TEXT DEFAULT '',
  p_description_b1 TEXT DEFAULT '',
  p_description_b2 TEXT DEFAULT '',
  p_description_c1 TEXT DEFAULT '',
  p_vocabulary JSONB DEFAULT '[]'::jsonb
)
RETURNS UUID
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
  new_id UUID;
BEGIN
  INSERT INTO articles (
    title, description, category, source,
    image_url, audio_url, base_level, published_at,
    content_a1, content_a2, content_b1, content_b2, content_c1,
    description_a1, description_a2, description_b1, description_b2, description_c1,
    vocabulary
  ) VALUES (
    p_title, p_description, p_category, p_source,
    p_image_url, p_audio_url, p_base_level, p_published_at,
    p_content_a1, p_content_a2, p_content_b1, p_content_b2, p_content_c1,
    p_description_a1, p_description_a2, p_description_b1, p_description_b2, p_description_c1,
    p_vocabulary
  )
  RETURNING id INTO new_id;
  RETURN new_id;
END;
$$;

GRANT EXECUTE ON FUNCTION public.insert_article TO anon;
GRANT EXECUTE ON FUNCTION public.insert_article TO authenticated;

-- 9. Upsert translation function
CREATE OR REPLACE FUNCTION public.upsert_translation(
  p_article_id UUID,
  p_language TEXT,
  p_level TEXT,
  p_title TEXT DEFAULT '',
  p_description TEXT DEFAULT '',
  p_content TEXT DEFAULT ''
)
RETURNS BOOLEAN
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO article_translations (article_id, language, level, title, description, content)
  VALUES (p_article_id, p_language, p_level, p_title, p_description, p_content)
  ON CONFLICT (article_id, language, level)
  DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content;
  RETURN TRUE;
END;
$$;

GRANT EXECUTE ON FUNCTION public.upsert_translation TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_translation TO authenticated;

-- 10. Get article with translation (one call)
CREATE OR REPLACE FUNCTION public.get_article_with_translation(
  p_article_id UUID,
  p_language TEXT DEFAULT 'ar',
  p_level TEXT DEFAULT 'B1'
)
RETURNS JSONB
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
  result JSONB;
  level_col TEXT;
  desc_col TEXT;
BEGIN
  -- Map level to column names
  level_col := CASE p_level
    WHEN 'A1' THEN 'content_a1'
    WHEN 'A2' THEN 'content_a2'
    WHEN 'B1' THEN 'content_b1'
    WHEN 'B2' THEN 'content_b2'
    WHEN 'C1' THEN 'content_c1'
    ELSE 'content_b1'
  END;
  desc_col := CASE p_level
    WHEN 'A1' THEN 'description_a1'
    WHEN 'A2' THEN 'description_a2'
    WHEN 'B1' THEN 'description_b1'
    WHEN 'B2' THEN 'description_b2'
    WHEN 'C1' THEN 'description_c1'
    ELSE 'description_b1'
  END;

  SELECT jsonb_build_object(
    'id', a.id,
    'title', a.title,
    'category', a.category,
    'source', a.source,
    'image_url', a.image_url,
    'published_at', a.published_at,
    'base_level', a.base_level,
    'vocabulary', a.vocabulary,
    'english_content', CASE
      WHEN p_level = 'A1' THEN a.content_a1
      WHEN p_level = 'A2' THEN a.content_a2
      WHEN p_level = 'B1' THEN a.content_b1
      WHEN p_level = 'B2' THEN a.content_b2
      WHEN p_level = 'C1' THEN a.content_c1
      ELSE a.content_b1
    END,
    'english_description', CASE
      WHEN p_level = 'A1' THEN a.description_a1
      WHEN p_level = 'A2' THEN a.description_a2
      WHEN p_level = 'B1' THEN a.description_b1
      WHEN p_level = 'B2' THEN a.description_b2
      WHEN p_level = 'C1' THEN a.description_c1
      ELSE a.description_b1
    END,
    'translated_title', COALESCE(t.title, a.title),
    'translated_description', COALESCE(t.description, ''),
    'translated_content', COALESCE(t.content, '')
  ) INTO result
  FROM articles a
  LEFT JOIN article_translations t
    ON t.article_id = a.id AND t.language = p_language AND t.level = p_level
  WHERE a.id = p_article_id;

  RETURN result;
END;
$$;

GRANT EXECUTE ON FUNCTION public.get_article_with_translation TO anon;
GRANT EXECUTE ON FUNCTION public.get_article_with_translation TO authenticated;

-- 11. RLS Policies
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE article_translations ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE saved_words ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Articles are public" ON articles CASCADE;
CREATE POLICY "Articles are public" ON articles
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Translations are public" ON article_translations CASCADE;
CREATE POLICY "Translations are public" ON article_translations
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can view own profile" ON profiles CASCADE;
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);
DROP POLICY IF EXISTS "Users can update own profile" ON profiles CASCADE;
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);
DROP POLICY IF EXISTS "Users can insert own profile" ON profiles CASCADE;
CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

DROP POLICY IF EXISTS "Users can manage own words" ON saved_words CASCADE;
CREATE POLICY "Users can manage own words" ON saved_words
  FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage own bookmarks" ON bookmarks CASCADE;
CREATE POLICY "Users can manage own bookmarks" ON bookmarks
  FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage own progress" ON user_progress CASCADE;
CREATE POLICY "Users can manage own progress" ON user_progress
  FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage own settings" ON user_settings CASCADE;
CREATE POLICY "Users can manage own settings" ON user_settings
  FOR ALL USING (auth.uid() = user_id);

-- 12. Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email)
  VALUES (NEW.id, NEW.raw_user_meta_data->>'name', NEW.email);
  INSERT INTO public.user_progress (user_id) VALUES (NEW.id);
  INSERT INTO public.user_settings (user_id) VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 13. Account deletion
CREATE OR REPLACE FUNCTION public.delete_user_account()
RETURNS void AS $$
DECLARE
  user_id UUID := auth.uid();
BEGIN
  DELETE FROM public.bookmarks WHERE user_id = delete_user_account.user_id;
  DELETE FROM public.saved_words WHERE user_id = delete_user_account.user_id;
  DELETE FROM public.user_progress WHERE user_id = delete_user_account.user_id;
  DELETE FROM public.user_settings WHERE user_id = delete_user_account.user_id;
  DELETE FROM public.profiles WHERE id = delete_user_account.user_id;
  DELETE FROM auth.users WHERE id = delete_user_account.user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
