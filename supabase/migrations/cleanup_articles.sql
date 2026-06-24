-- ===================================================
-- ⚠️  TRUNCATE all articles + related data
-- Run ONCE in Supabase Dashboard > SQL Editor
-- Before: python3 scripts/fetch_news.py
-- ===================================================

-- Option A: Delete everything cleanly (cascades to translations, bookmarks, saved_words)
TRUNCATE TABLE article_translations, bookmarks, saved_words, articles RESTART IDENTITY CASCADE;

-- Option B: Same via SECURITY DEFINER function (callable from Python script later)
CREATE OR REPLACE FUNCTION public.clear_articles()
RETURNS INT
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
  total INT;
BEGIN
  DELETE FROM article_translations;
  DELETE FROM bookmarks;
  DELETE FROM saved_words;
  DELETE FROM articles;
  GET DIAGNOSTICS total = ROW_COUNT;
  RETURN total;
END;
$$;
GRANT EXECUTE ON FUNCTION public.clear_articles TO anon;
GRANT EXECUTE ON FUNCTION public.clear_articles TO authenticated;

-- Verify it worked
SELECT COUNT(*) AS remaining_articles FROM articles;
