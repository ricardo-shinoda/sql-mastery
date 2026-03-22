-- Table1: artists
-- id: Serial/Primary Key.
-- name: Varchar.
-- genre: Varchar.
-- country_of_origin: Varchar.

CREATE TABLE artists(
    artist_id BIGSERIAL NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    country_of_origin VARCHAR (50)
    CONSTRAINT artist_id_artists_pk PRIMARY KEY (artist_id)
);

-- Table2: albums
-- id: Serial/Primary Key.
-- artist_id: Foreign Key (referencing artists).
-- title: Varchar.
-- release_year: Integer.



-- Table3: songs
-- id: Serial/Primary Key.

-- album_id: Foreign Key (referencing albums).

-- name: Varchar.

-- duration_seconds: Integer.

-- bpm: Integer (excellent for filtering/analysis).

-- Table4: users
-- id: Serial/Primary Key.

-- name: Varchar.

-- email: Varchar.

-- plan: Varchar ('free', 'premium').

-- created_at: Date (Use the CURRENT_DATE - interval tip).

-- Table4: streaming_history (The "Fact/Transactional" Table)
-- id: BigSerial/Primary Key.

-- user_id: Foreign Key (referencing users).

-- song_id: Foreign Key (referencing songs).

-- played_at: Timestamp (This is where we use dynamic dates).

-- device: Varchar ('mobile', 'desktop', 'web').