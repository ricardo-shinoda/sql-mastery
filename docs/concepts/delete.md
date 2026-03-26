## Deleting an value in DB

**This is very important**
#### Never (ever) run DELETE clause without the WHERE
`Otherwise you will delete everything if you need to delete an value, always say which value, usualy by saying what is the ID to delete.`

1. DELETE vs ID Sequences
With DELETE only:

If you have an auto-incrementing SERIAL or BIGSERIAL (identity) column, the sequence does NOT reset

If you deleted rows with IDs 1, 2, 3, the next insert will get ID 4 (not 1)

Example:

```sql
-- After DELETE, sequence value persists
DELETE FROM users;  -- Removed rows 1,2,3
INSERT INTO users (name) VALUES ('John');  -- Gets ID 4
```
To reset the sequence after DELETE:

Option A: TRUNCATE (automatically resets sequence)
```sql
TRUNCATE TABLE users RESTART IDENTITY;
```

Option B: Manual sequence reset after DELETE
```sql DELETE FROM users;
ALTER SEQUENCE users_id_seq RESTART WITH 1;
```

Option C: If using PostgreSQL 10+ with IDENTITY
```sql
TRUNCATE TABLE users RESTART IDENTITY;
```
To check your sequence name:
```sql
SELECT pg_get_serial_sequence('your_table_name', 'id');
```