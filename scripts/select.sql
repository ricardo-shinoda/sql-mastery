SELECT COUNT(*) FROM streaming_history;

SELECT 
    (SELECT COUNT(*) FROM users) as total_usuarios,
    (SELECT COUNT(*) FROM song) as total_musicas,
    (SELECT COUNT(*) FROM streaming_history) as total_reproducoes;
    