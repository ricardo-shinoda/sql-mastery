import random
import os
import datetime
from faker import Faker

fake = Faker()

# Configurações de volume de dados
num_artists = 400
num_users = 300
num_plays = 2000 # Aumentei para o seu banco ficar bem robusto

# Configuração de caminhos (Linux/Mac)
root_path = os.getcwd() 
target_dir = os.path.join(root_path, "scripts", "db-init")
os.makedirs(target_dir, exist_ok=True)
sql_output = os.path.join(target_dir, "02-insert-data.sql")

# Listas auxiliares para dados mais realistas
genres = ['Synthwave', 'Post-Punk', 'MPB', 'Jazz Fusion', 'Techno', 'Indie Rock', 'Bossa Nova', 'Heavy Metal', 'Lo-fi', 'Phonk']
countries = ['Brazil', 'USA', 'UK', 'Germany', 'Japan', 'France', 'Canada', 'Australia', 'Sweden', 'Iceland']
plans = ['free', 'premium', 'enterprise'] # TUDO EM MINÚSCULO para bater com o CHECK do SQL
devices = ['mobile', 'desktop', 'tablet', 'smart_tv']

print(f"Gerando dados em: {sql_output}...")

with open(sql_output, "w", encoding="utf-8") as f:
    f.write("-- Automated Data Generation for Music Schema\n")
    f.write("SET client_encoding = 'UTF8';\n\n")

    # 1. GENERATE USERS
    f.write("-- INSERT USERS\n")
    used_emails = set() # Para rastrear e-mails já gerados

    i = 1
    while i <= num_users:
        email = fake.unique.email() # O Faker tem um gerador nativo de únicos!
        name = fake.name().replace("'", "''")
        plan = random.choice(plans)
    
        f.write(f"INSERT INTO users (user_id, name, email, plan, created_at) "
            f"VALUES ({i}, '{name[:50]}', '{email[:50]}', '{plan}', NOW());\n")
        i += 1      

    # 2. GENERATE ARTISTS
    f.write("\n-- INSERT ARTISTS\n")
    for i in range(1, num_artists + 1):
        name = (fake.name() if random.random() > 0.5 else f"The {fake.word().capitalize()}s").replace("'", "''")
        f.write(f"INSERT INTO artist (artist_id, artist_name, genre, country_of_origin) "
                f"VALUES ({i}, '{name[:100]}', '{random.choice(genres)}', '{random.choice(countries)}');\n")

    # 3. GENERATE ALBUMS & SONGS
    f.write("\n-- INSERT ALBUMS AND SONGS\n")
    album_id_seq = 1
    song_id_seq = 1
    
    for artist_id in range(1, num_artists + 1):
        for _ in range(random.randint(1, 3)):
            album_title = fake.catch_phrase().replace("'", "''")
            f.write(f"INSERT INTO album (album_id, artist_id, title, release_year, created_at) "
                    f"VALUES ({album_id_seq}, {artist_id}, '{album_title[:100]}', {random.randint(1970, 2026)}, NOW());\n")
            
            for track_num in range(1, random.randint(6, 11)):
                song_name = fake.sentence(nb_words=random.randint(1, 4)).replace(".", "").replace("'", "''")
                f.write(f"INSERT INTO song (song_id, album_id, name, duration_seconds, bpm, track_number) "
                        f"VALUES ({song_id_seq}, {album_id_seq}, '{song_name[:100]}', {random.randint(120, 480)}, {random.randint(60, 180)}, {track_num});\n")
                song_id_seq += 1
            album_id_seq += 1

    # 4. GENERATE STREAMING HISTORY (Com a coluna DEVICE corrigida)
    f.write("\n-- INSERT STREAMING HISTORY\n")
    now = datetime.datetime.now()
    max_song_id = song_id_seq - 1

    for _ in range(num_plays):
        u_id = random.randint(1, num_users)
        s_id = random.randint(1, max_song_id)
        device = random.choice(devices)
        play_date = fake.date_time_between(start_date='-1y', end_date=now)
        
        f.write(f"INSERT INTO streaming_history (user_id, song_id, played_at, device) "
                f"VALUES ({u_id}, {s_id}, '{play_date.strftime('%Y-%m-%d %H:%M:%S')}', '{device}');\n")

print(f"\nSucesso! Arquivo gerado com {num_plays} registros de histórico.")
print(f"Total de músicas disponíveis para play: {max_song_id}")