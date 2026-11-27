# QA SQL and Postman Practice

Practice project for the backend side of QA work: checking data with SQL and
testing a REST API with Postman. The domain is a small game store (players, games,
purchases, achievements), similar to a Steam-like platform.

## What is covered

### SQL (`sql_practice/`)
- `game_store.db` - SQLite database with 4 tables: `players`, `games`, `purchases`,
  `achievements`
- `queries.sql` - queries practiced on this schema: `SELECT`, `WHERE`, `ORDER BY`,
  `LIMIT`, `JOIN` (including three tables), `LEFT JOIN ... IS NULL`, `COUNT`, `SUM`,
  `GROUP BY`, `HAVING`
- `test_db.py` - database checks written with pytest and the built-in `sqlite3` module
  (fixture with `yield` that opens and closes the connection)

### Postman (`postman/`)
- Collection `JSONPlaceholder` with 3 requests (`GET /users/1`, `GET /users/999`,
  `POST /posts`) and post-response tests (status code, response fields)
- Environment `jsonplaceholder` with the `base_url` variable

## Found data bug
`test_no_illegal_refunds` finds a refunded purchase with more than 120 minutes of
playtime (purchase `id = 7`), which violates the Steam refund rule. The test is marked
`xfail` so that CI stays green while the bug stays documented.

## Tech stack
- SQL (SQLite)
- Python, pytest, ruff
- Postman (collection stored as files in local mode)
- GitHub Actions

## How to run

1. Create and activate a virtual environment, install dependencies:

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

2. Run the database tests from the project root:

   ```bash
   python -m pytest -v
   ```

3. Run the SQL queries from the file:

   ```bash
   sqlite3 -header -column sql_practice/game_store.db < sql_practice/queries.sql
   ```

4. Postman: import the `postman/` folder (or open it in Postman local mode), select the
   `jsonplaceholder` environment and run the collection.
