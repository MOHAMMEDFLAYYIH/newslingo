-- ===================================================
-- Schedule news fetch every 7 days via pg_cron
-- Run this in Supabase Dashboard > SQL Editor
-- Requires: pg_cron extension enabled
-- ===================================================

-- Enable pg_cron (one-time)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule the edge function to run weekly
-- Uses Supabase's built-in cron HTTP call
SELECT cron.schedule(
  'fetch-news-weekly',              -- job name
  '0 6 * * 1',                      -- every Monday at 6:00 AM
  $$SELECT net.http_post(
    url := 'https://PROJECT_REF.supabase.co/functions/v1/fetch-news',
    headers := '{"Authorization":"Bearer YOUR_ANON_KEY"}'::jsonb
  )$$
);

-- View scheduled jobs
SELECT * FROM cron.job;

-- Remove job if needed:
-- SELECT cron.unschedule('fetch-news-weekly');
