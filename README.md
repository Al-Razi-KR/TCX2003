# TCX2003: Database Systems and Management

**Semester:** May–July 2026 (2530)  
**Venue:** Lectures Mon 7pm–9pm | Tutorials Wed 7pm–9pm  
**Format:** Flipped classroom — watch pre-recorded videos before each lecture

---

## Assessments

| Assessment | Weight | Date / Details |
|---|---|---|
| 4 Take-home Quizzes | 10% | One per video lecture; score = sum × 0.25, capped at 10 |
| Project Demo | 30% | 24 Jun 2026, 6:30pm–10pm (overflow: 29 Jun); teams of 1–5 students |
| Class Test | 20% | 1 Jul 2026, 7pm–9pm, in-person on campus |
| Final Exam | 40% | 13 Jul 2026, 9am–11am, in-person, via Examplify |

---

## Learning Outcomes

1. Express data queries in SQL
2. Model data requirements as relational tables
3. Understand design and implementation of a data management application with an RDBMS
4. Visualize different data types using basic visualization tools

---

## Repository Structure

```
TCX2003/
├── README.md
├── CLAUDE.md
├── calendar.md
├── announcements/      # Instructor announcements, named by date and topic
├── lessons/
│   ├── L1-create-sql-table/
│   ├── L2-sql-query/
│   ├── L3-database-application/
│   └── L4-database-design/
├── tutorials/
│   ├── T1/
│   ├── T2/
│   └── T3/
├── quizzes/
│   ├── Q1/
│   ├── Q2/
│   ├── Q3/
│   └── Q4/
├── project/            # Deliverables, schema designs, SQL scripts, demo prep
├── resources/          # Course overview, assessment rules, helpful links
└── sql-practice/       # Local Postgres sandbox via Docker
    ├── docker-compose.yml
    └── init/           # SQL files auto-loaded on first container start
        └── 01_seed.sql
```

---

## SQL Practice Environment

A local PostgreSQL 16 sandbox lives in [sql-practice/](sql-practice/). It runs in Docker and auto-loads every `.sql` file under `init/` on first start.

**Prerequisites:** [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.

### Start the database

```bash
cd sql-practice
docker compose up -d
```

### Connect with psql

```bash
docker exec -it sql-practice-db-1 psql -U student -d practice
```

Or from any local psql client:

```
Host:     localhost
Port:     5432
User:     student
Password: password
Database: practice
```

### Stop the container

```bash
docker compose down          # stops and removes the container (data is preserved)
docker compose down -v       # also wipes the volume — full reset to seed data
```

### Add more practice scripts

Drop a new `.sql` file into `init/` (e.g. `02_queries.sql`). It will be picked up automatically on the next fresh start (`docker compose down -v && docker compose up -d`).

---

## Key Dates

| Date | Event |
|---|---|
| 11 May 2026 | Lecture 1 |
| 13 May 2026 | Tutorial 1 (T1 & T2) |
| 20 May 2026 | Tutorial 1 (T3 & T4) — project teams formed |
| 25 May 2026 | Lecture 2 |
| 27 May 2026 | No class (Public Holiday) |
| 3 Jun 2026 | Tutorial 2 (all groups) |
| 8 Jun 2026 | Lecture 3 |
| 10 Jun 2026 | Tutorial 3 (T1 & T2) |
| 17 Jun 2026 | Tutorial 3 (T3 & T4) |
| 22 Jun 2026 | Lecture 4 |
| 24 Jun 2026 | **Project Demo** (6:30pm–10pm) |
| 1 Jul 2026 | **Class Test** (7pm–9pm) |
| 13 Jul 2026 | **Final Exam** (9am–11am) |
