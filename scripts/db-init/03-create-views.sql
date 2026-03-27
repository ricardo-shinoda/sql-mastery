-- Standardizing for Global Data Engineering standards
DROP VIEW IF EXISTS v_artist_ranking_by_plan;

CREATE OR REPLACE VIEW v_artist_ranking_by_plan AS
SELECT 
    a.name AS artist_name,
    u.plan AS user_plan,
    COUNT(sh.history_id) AS total_streams,
    RANK() OVER (
        PARTITION BY u.plan 
        ORDER BY COUNT(sh.history_id) DESC
    ) AS ranking_position
FROM artist a
JOIN song s ON a.artist_id = s.artist_id
JOIN streaming_history sh ON s.song_id = sh.song_id
JOIN users u ON sh.user_id = u.user_id
GROUP BY a.name, u.plan;

-- Adding metadata for better documentation
COMMENT ON VIEW v_artist_ranking_by_plan IS 'Artist popularity ranking segmented by user plan (Free/Premium). Used for business performance analysis.';