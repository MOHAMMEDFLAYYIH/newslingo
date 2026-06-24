-- ===================================
-- Run this in Supabase Dashboard > SQL Editor
-- 1. Deletes ALL articles + related data
-- 2. Creates/updates insert_article function (for fetch_news.py)
-- 3. Creates clear_articles function
-- ===================================

-- 1. Delete all articles (uses TRUNCATE to avoid DELETE without WHERE restriction)
TRUNCATE TABLE article_translations, bookmarks, saved_words, articles RESTART IDENTITY CASCADE;

-- 2. Create the insert_article function (REQUIRED for fetch_news.py)
DROP FUNCTION IF EXISTS public.insert_article;

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
  p_vocabulary JSONB DEFAULT '[]'::jsonb,
  p_quiz JSONB DEFAULT '[]'::jsonb
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
    vocabulary, quiz
  ) VALUES (
    p_title, p_description, p_category, p_source,
    p_image_url, p_audio_url, p_base_level, p_published_at,
    p_content_a1, p_content_a2, p_content_b1, p_content_b2, p_content_c1,
    p_description_a1, p_description_a2, p_description_b1, p_description_b2, p_description_c1,
    p_vocabulary, p_quiz
  )
  RETURNING id INTO new_id;
  RETURN new_id;
END;
$$;

GRANT EXECUTE ON FUNCTION public.insert_article TO anon;
GRANT EXECUTE ON FUNCTION public.insert_article TO authenticated;

-- 3. Create clear_articles function (uses TRUNCATE instead of DELETE)
CREATE OR REPLACE FUNCTION public.clear_articles()
RETURNS INT
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
  total INT;
BEGIN
  TRUNCATE TABLE article_translations, bookmarks, saved_words, articles RESTART IDENTITY CASCADE;
  GET DIAGNOSTICS total = ROW_COUNT;
  RETURN total;
END;
$$;

GRANT EXECUTE ON FUNCTION public.clear_articles TO anon;
GRANT EXECUTE ON FUNCTION public.clear_articles TO authenticated;

-- Verify
SELECT COUNT(*) AS remaining_articles FROM articles;
