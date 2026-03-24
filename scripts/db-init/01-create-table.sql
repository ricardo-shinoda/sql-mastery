-- Table1: artists
-- id: Serial/Primary Key.
-- name: Varchar.
-- genre: Varchar.
-- country_of_origin: Varchar.

CREATE TABLE artist(
    artist_id BIGSERIAL NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    country_of_origin VARCHAR (50)
    CONSTRAINT artist_artist_id_pk PRIMARY KEY (artist_id)
);

-- Table2: albums
-- id: Serial/Primary Key.
-- artist_id: Foreign Key (referencing artists).
-- title: Varchar.
-- release_year: Integer.

CREATE TABLE album(
    album_id BIGSERIAL NOT NULL,
    artist_id INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL,
    CONSTRAINT album_album_id_pk PRIMARY KEY (album_id),
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
    song_id BIGSERIAL NOT NULL,
    album_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    release_year INTEGER,
    duration_seconds INTEGER,
    bpm INTEGER,
    CONSTRAINT song_song_id_pk PRIMARY KEY song(song_id),
    CONSTRAINT algum_album_id 
        FOREIGN KEY (album_id)
        REFERENCES album(algum_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    CONSTRAINT album_release_year_pk
        FOREIGN KEY (release_year)
        REFERENCES album(release_year)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table4: users
-- id: Serial/Primary Key.
-- name: Varchar.
-- email: Varchar.
-- plan: Varchar ('free', 'premium').
-- created_at: Date (Use the CURRENT_DATE - interval tip).

CREATE TABLE user(
    user_id BIGSERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    plan VARCHAR(10) NOT NULL,
    created_at CURRENT_DATE NOR NULL,
    CONSTRAINT user_user_id_pk PRIMARY KEY (user_id)
);

-- Table4: streaming_history (The "Fact/Transactional" Table)
-- id: BigSerial/Primary Key.
-- user_id: Foreign Key (referencing users).
-- song_id: Foreign Key (referencing songs).
-- played_at: Timestamp (This is where we use dynamic dates).
-- device: Varchar ('mobile', 'desktop', 'web').

CREATE TABLE streaming_history(
    streaming_id BIGSERIAL NOT NULL,
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    played_at TIMESTAMP NOT NULL,
    device VARCHAR(10),
    CONSTRAINT streaming_history_streaming_id_pk PRIMARY KEY (streaming_id)
    CONSTRAINT user_user_id_fk
        FOREIGN KEY (user_id)
        REFERENCES user(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    CONSTRAINT song_song_id_pk
        FOREIGN KEY (song_id)
        REFERENCES song(song_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);