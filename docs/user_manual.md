🚀 SQL Study Workflow (Cross-Platform)
This guide outlines the daily routine for syncing studies between your macOS (Work) and Manjaro Linux (Home) environments using Git and Docker.

💻 Daily Routine
At Work (macOS)
Sync Repo: Run git pull to fetch the latest updates from your home session.

Start Engine: Open OrbStack (wait for the icon in the top bar to stop blinking).

Launch DB: Run docker-compose up -d.

Study & Document:

Create new .md files in docs/ for theory.

Write and execute SQL scripts in exercises/.

Save Progress:

Bash
git add .
git commit -m "feat: add notes and exercises on window functions"
git push
⚠️ Important: Before closing your Mac, run docker-compose stop and Quit OrbStack to save battery and RAM.

At Home (Manjaro Linux)
Sync Repo: Run git pull.

Launch DB: Run docker-compose up -d.

Continue: All your texts, notes, and scripts will be ready in VS Code.

🛠️ Database Reset & Troubleshooting
How to Factory Reset the Database
If you need to delete everything (tables, data, and schema) and start fresh from your 01-create-table.sql script:

Bash
# Shutdown and delete the data volume
docker-compose down -v

# Start a clean instance
docker-compose up -d
down -v: The -v flag is the key—it deletes the current data volume.

up -d: Since the volume is now empty, Docker will automatically re-run your 01-create-table.sql script located in the db-init folder.

Checking for Script Errors
Don't guess if your SQL scripts worked. Check the live logs immediately after running up -d to catch syntax errors:

Bash
# The "Magic" Command
docker logs -f sql_study_postgres
Pro Tip: Look for lines starting with ERROR: in the log output. If you see CREATE TABLE, your script executed successfully!