-- =============================================================
-- NewsLingo Supabase Database Schema
-- Run this in Supabase Dashboard > SQL Editor
-- =============================================================

-- 1. Articles
CREATE TABLE articles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL,
  source TEXT NOT NULL DEFAULT 'NewsLingo',
  image_url TEXT,
  audio_url TEXT,
  level TEXT DEFAULT 'beginner',
  published_at TIMESTAMPTZ DEFAULT NOW(),
  tags TEXT[] DEFAULT '{}',
  vocabulary JSONB DEFAULT '[]'::jsonb,
  quiz JSONB DEFAULT '{}'::jsonb
);

-- 2. User Profiles (linked to Supabase Auth)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  name TEXT,
  email TEXT,
  avatar_url TEXT,
  level TEXT DEFAULT 'beginner',
  bio TEXT DEFAULT '',
  interests TEXT[] DEFAULT '{}',
  onboarding_complete BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Saved Words
CREATE TABLE saved_words (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  word TEXT NOT NULL,
  definition TEXT NOT NULL,
  translation TEXT,
  article_id TEXT,
  part_of_speech TEXT DEFAULT '',
  saved_at TIMESTAMPTZ DEFAULT NOW(),
  review_count INT DEFAULT 0,
  next_review_date TIMESTAMPTZ,
  UNIQUE(user_id, word)
);

-- 4. Bookmarks
CREATE TABLE bookmarks (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  article_id UUID REFERENCES articles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (user_id, article_id)
);

-- 5. User Progress
CREATE TABLE user_progress (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  streak INT DEFAULT 0,
  articles_read INT DEFAULT 0,
  words_learned INT DEFAULT 0,
  quizzes_passed INT DEFAULT 0,
  last_active_date TIMESTAMPTZ
);

-- 6. User Settings
CREATE TABLE user_settings (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  language TEXT DEFAULT 'ar',
  notifications_enabled BOOLEAN DEFAULT true,
  daily_reminder BOOLEAN DEFAULT false,
  reminder_time TIME DEFAULT '09:00',
  dark_mode BOOLEAN DEFAULT false,
  sound_effects BOOLEAN DEFAULT true,
  auto_play_audio BOOLEAN DEFAULT false
);

-- =============================================================
-- Row Level Security (RLS)
-- =============================================================
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE saved_words ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

-- Articles: public read
CREATE POLICY "Articles are public" ON articles
  FOR SELECT USING (true);

-- Profiles: user can read/update own profile
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Saved words: user can CRUD own words
CREATE POLICY "Users can manage own words" ON saved_words
  FOR ALL USING (auth.uid() = user_id);

-- Bookmarks: user can CRUD own bookmarks
CREATE POLICY "Users can manage own bookmarks" ON bookmarks
  FOR ALL USING (auth.uid() = user_id);

-- Progress: user can read/update own progress
CREATE POLICY "Users can manage own progress" ON user_progress
  FOR ALL USING (auth.uid() = user_id);

-- Settings: user can read/update own settings
CREATE POLICY "Users can manage own settings" ON user_settings
  FOR ALL USING (auth.uid() = user_id);

-- =============================================================
-- Triggers
-- =============================================================
-- Auto-create profile on signup
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

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =============================================================
-- Account Deletion
-- =============================================================
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

-- =============================================================
-- Seed Articles
-- Run lib/core/constants/seed_articles.sql after schema is applied
-- =============================================================
