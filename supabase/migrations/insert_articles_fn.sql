-- ===================================================
-- Function: insert_article (bypasses RLS)
-- Run in Supabase Dashboard > SQL Editor
-- ===================================================

CREATE OR REPLACE FUNCTION public.insert_article(
  p_id TEXT,
  p_title TEXT,
  p_description TEXT,
  p_content TEXT,
  p_category TEXT,
  p_source TEXT,
  p_image_url TEXT,
  p_audio_url TEXT,
  p_level TEXT,
  p_published_at TIMESTAMPTZ,
  p_tags TEXT[],
  p_vocabulary JSONB DEFAULT '[]'::jsonb,
  p_quiz JSONB DEFAULT '{}'::jsonb
)
RETURNS BOOLEAN
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO articles (
    id, title, description, content, category, source,
    image_url, audio_url, level, published_at, tags,
    vocabulary, quiz
  ) VALUES (
    p_id, p_title, p_description, p_content, p_category, p_source,
    p_image_url, p_audio_url, p_level, p_published_at, p_tags,
    p_vocabulary, p_quiz
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN FOUND;
END;
$$;

-- Grant execute to anon role (so Python script can call it)
GRANT EXECUTE ON FUNCTION public.insert_article TO anon;
GRANT EXECUTE ON FUNCTION public.insert_article TO authenticated;

-- ===================================================
-- Schedule weekly fetch via pg_cron
-- ===================================================
CREATE EXTENSION IF NOT EXISTS pg_cron;

SELECT cron.schedule(
  'fetch-news-weekly',
  '0 6 * * 1',
  $$SELECT net.http_post(
    url := 'https://qwxsntvobtfjldurswfq.supabase.co/functions/v1/fetch-news',
    headers := '{"Content-Type":"application/json"}'::jsonb
  )$$
);
