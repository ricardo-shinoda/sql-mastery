#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${BLUE}=== Data Pipeline Orchestration Started ===${NC}"

# 1. CLEANUP
echo -e "${GREEN}[1/6] Tearing down old containers and volumes...${NC}"
docker-compose down -v > /dev/null 2>&1

# 2. INGESTION PREP
echo -e "${GREEN}[2/6] Executing Python Data Generator...${NC}"
if [ -d ".venv" ]; then
    source .venv/bin/activate
    python scripts/data-generator.py
else
    echo -e "${RED}Error: .venv not found.${NC}"
    exit 1
fi

# 3. INFRASTRUCTURE
echo -e "${GREEN}[3/6] Starting Docker containers...${NC}"
docker-compose up -d

# 4. HEALTHCHECK & NETWORK STABILIZATION
echo -e "${GREEN}[4/6] Waiting for Network Bridge and PostgreSQL (Port 5433)...${NC}"
MAX_RETRIES=15
COUNT=0

# Tenta conectar via 127.0.0.1:5433 repetidamente
until docker exec music_postgres pg_isready -h 127.0.0.1 -p 5433 -U postgres > /dev/null 2>&1 || [ $COUNT -eq $MAX_RETRIES ]; do
  echo -n "."
  sleep 2
  ((COUNT++))
done

if [ $COUNT -eq $MAX_RETRIES ]; then
    echo -e "${RED}\nError: Database connection timed out on port 5433.${NC}"
    exit 1
fi

echo -e "\n${GREEN}Connection established!${NC}"

# 5. TRANSFORMATION
echo -e "${GREEN}[5/6] Applying SQL Transformation Layer (Views)...${NC}"
docker exec -i music_postgres psql -h 127.0.0.1 -p 5433 -U postgres -d sql_study < scripts/db-init/03-create-views.sql

# 6. VALIDATION
echo -e "${GREEN}[6/6] Validating Row Counts from Analytics View...${NC}"
docker exec -i music_postgres psql -h 127.0.0.1 -p 5433 -U postgres -d sql_study -c "SELECT count(*) AS total_records FROM v_artist_ranking_by_plan;"

echo -e "${BLUE}=== Setup Successful! Your environment is ready. ===${NC}"