import sqlite3

import pytest


@pytest.fixture
def db_cursor():
    conn = sqlite3.connect("sql_practice/game_store.db")
    cursor = conn.cursor()
    yield cursor
    conn.close()


def test_total_completed_revenue(db_cursor):
    db_cursor.execute(
        "SELECT COUNT(*), SUM(price_paid) FROM purchases WHERE status = 'completed';"
    )
    row = db_cursor.fetchone()
    assert row[0] == 7
    assert row[1] == 154.95


@pytest.mark.xfail(
    reason="Bug: refund approved with playtime > 120 min (purchase id=7)"
)
def test_no_illegal_refunds(db_cursor):
    db_cursor.execute(
        "SELECT * FROM purchases WHERE status = 'refunded' AND playtime_minutes > 120;"
    )
    rows = db_cursor.fetchall()
    assert rows == []
