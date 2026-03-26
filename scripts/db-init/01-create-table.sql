-- Table1: artists
-- id: Serial/Primary Key.
-- name: Varchar.
-- genre: Varchar.
-- country_of_origin: Varchar.

CREATE TABLE artist(
    artist_id BIGSERIAL PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    country_of_origin VARCHAR (50)
);

-- Table2: albums
-- id: Serial/Primary Key.
-- artist_id: Foreign Key (referencing artists).
-- title: Varchar.
-- release_year: Integer.

CREATE TABLE album(
    album_id BIGSERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(), -- TO ASK
    CONSTRAINT artist_id_fk 
        FOREIGN KEY (artist_id)
        REFERENCES artist(artist_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Table3: songs
-- id: Serial/Primary Key.
-- album_id: Foreign Key (referencing albums).
-- name: Varchar.
-- duration_seconds: Integer.
-- bpm: Integer (excellent for filtering/analysis).

CREATE TABLE song(
    song_id BIGSERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    duration_seconds INTEGER CHECK (duration_seconds > 0), -- TO ASK
    bpm INTEGER CHECK (bpm BETWEEN 20 AND 300), -- TO ASK
    track_number INTEGER, -- Útil para ordenação
    CONSTRAINT album_album_id 
        FOREIGN KEY (album_id)
        REFERENCES album(album_id)
        ON DELETE CASCADE -- If album is deleted, so is the songs
        ON UPDATE CASCADE
 );

-- Table4: users
-- id: Serial/Primary Key.
-- name: Varchar.
-- email: Varchar.
-- plan: Varchar ('free', 'premium').
-- created_at: Date (Use the CURRENT_DATE - interval tip).

CREATE TABLE users( -- Plural to differenciate from reserved word
    user_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    plan VARCHAR(20) NOT NULL DEFAULT 'free', -- TO ASK
    created_at TIMESTAMP NOT NULL DEFAULT NOW(), -- TO ASK
    CONSTRAINT chk_plan CHECK (plan IN ('free', 'premium', 'enterprise')) -- TO ASK
);

-- Table5: streaming_history (The "Fact/Transactional" Table)
-- id: BigSerial/Primary Key.
-- user_id: Foreign Key (referencing users).
-- song_id: Foreign Key (referencing songs).
-- played_at: Timestamp (This is where we use dynamic dates).
-- device: Varchar ('mobile', 'desktop', 'web').

CREATE TABLE streaming_history(
    streaming_id BIGSERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    played_at TIMESTAMP WITH TIME ZONE NOT NULL, -- TO ASK
    device VARCHAR(20) NOT NULL,
    CONSTRAINT user_user_id_fk
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT song_song_id_pk
        FOREIGN KEY (song_id)
        REFERENCES song(song_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);