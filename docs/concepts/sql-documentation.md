## Primary Key

### When to user PK in-line or out-of-line?
#### If it's an unique primary key, use in-line:

```sql
CREATE TABLE album_artist (
    album_id INTEGER PRIMARY KEY,
);
```


### If it's a compound primary key, use out-of-line:
```sql
CREATE TABLE album_artist (
    album_id INTEGER NOT NULL,
    artist_id INTEGER NOT NULL,
    CONSTRAINT pk_album_artist PRIMARY KEY (album_id, artist_id)
);
```

## CONSTRAINTS - Naming
```sql
CONSTRAINT fk_streaming_user      -- fk_[tabela_filha]_[tabela_pai]
CONSTRAINT fk_streaming_song      -- ou fk_[tabela_filha]_[coluna]
```

Most commum user from senior DE:

| Tipo | Padrão | Exemplo |
| :--- | :--- | :--- |
| **PK** | `pk_[table]` | `pk_artist` |
| **FK** | `fk_[child]_[parent]` | `fk_album_artist` |
| **FK** | `fk_[child]_[column]` | `fk_album_artist_id` |
| **UK** | `uk_[table]_[column]` | `uk_user_email` |
| **CK** | `chk_[table]_[description]` | `chk_song_duration` |


## TIMESTAMP, CURRENT_DATE, NOW()
### TIMESTAMP

| Type | Description | Example | Best for
| :--- | :--- | :--- | :--- |
| **DATE** | YYYY-MM-DD | `2024-03-24` | DOB, Fixed Calendar dates | 
| **TIMESTAMP** | Date and time **without** timezone | `2024-03-24 15:30:00` | Relative times
| **TIMESTAMPTZ** | Date and time **with** timezone (UTC) | `2024-03-24 15:30:00-03` |  Logs, Transactions, Events
| **CURRENT_DATE** | Only the date (no time) | `2024-03-24` | Session dependent
| **NOW()** | Date and time with timezone | `2024-03-24 15:30:45.123+00` | Default for event occurrence
| **CURRENT_TIMESTAMP** | Equivalent to `NOW()` | `2024-03-24 15:30:45.123+00` |

---

```sql
-- Inserting a generic timestamp
INSERT INTO log (created_at) VALUES ('2024-03-24 15:30:00');

-- User in Brazil sees: 15:30
-- User in Japan sees: 15:30 (But it was actually 03:30 AM in Japan!)
-- Result: You lose the global context of when the event actually occurred.

-- Inserting the current moment
INSERT INTO log (created_at) VALUES (NOW());

-- Internally stores: 2024-03-24 18:30:00+00 (UTC)
-- User in Brazil: Sees 15:30 (-03:00)
-- User in Japan: Sees 03:30 (+09:00)
-- Result: Every user sees the event at the correct time for their location!
```

```sql
-- All equivalent:
DEFAULT NOW()                -- Function
DEFAULT CURRENT_TIMESTAMP    -- SQL pattern
DEFAULT CURRENT_TIMESTAMP(0) -- With precision

-- Todos retornam TIMESTAMPTZ
```

## CHECK 
CHECK constraint validate the date before insert or update
The ideia is to make sure that the date being used are a valid and will not mess the DB

## DEFAULT 'Free'
DEFAULT define an automactly value for when the field is not informted on the INSERT

It's commum and safe to use this combination:
```sql
plan VARCHAR(20) NOT NULL DEFAULT 'Free'
```

## CHECK with IN
```sql
CONSTRAINT chck_plan CHECK (plan IN ('Free', 'Premium', 'Enterprise'))
```

| Plan Type | Allowed | Example Value |
| :--- | :--- | :--- |
| **FREE** | Yes | `'free'` |
| **PREMIUM** | Yes | `'premium'` |
| **GOLD** | No | `❌ (Not in defined list)` |

### Postgres Quick Reference
* Use **TIMESTAMPTZ** for almost everything.
* Use **DATE** for birthdays or simple calendar marks.
* Use **CHECK** constraints for flexible status/plan management.