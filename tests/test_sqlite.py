"""Executa schema + seed + as 12 consultas em SQLite (so stdlib) e confere os resultados.

Valida apenas o dialeto SQLite, que e o das consultas como estao escritas.
O equivalente PostgreSQL indicado em queries.sql nao e testado aqui.
"""
import sqlite3
from pathlib import Path

import pytest

RAIZ = Path(__file__).resolve().parent.parent
ESPERADO = [4, 3, 2, 2, 3, 4, 5, 4, 3, 4, 2, 11]  # linhas por consulta, na ordem


@pytest.fixture()
def db():
    con = sqlite3.connect(":memory:")
    con.execute("PRAGMA foreign_keys = ON")
    con.executescript((RAIZ / "schema.sql").read_text(encoding="utf-8"))
    con.executescript((RAIZ / "seed.sql").read_text(encoding="utf-8"))
    yield con
    con.close()


def consultas():
    texto = (RAIZ / "queries.sql").read_text(encoding="utf-8")
    return [p for p in texto.split(";") if p.strip()]


def test_seed_tem_o_volume_documentado(db):
    contagem = lambda t: db.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0]
    assert (contagem("clients"), contagem("agents"), contagem("tickets"),
            contagem("ticket_comments")) == (6, 3, 14, 25)


def test_sao_12_consultas():
    assert len(consultas()) == 12


@pytest.mark.parametrize("i", range(12))
def test_consulta_roda_e_retorna_o_esperado(db, i):
    assert len(db.execute(consultas()[i]).fetchall()) == ESPERADO[i]


def test_clientes_com_mais_de_2_tickets_confere_com_contagem_direta(db):
    direto = db.execute(
        "SELECT COUNT(*) FROM (SELECT client_id FROM tickets GROUP BY client_id HAVING COUNT(*) > 2)"
    ).fetchone()[0]
    assert len(db.execute(consultas()[2]).fetchall()) == direto


def test_tickets_sem_comentario_confere_com_left_join(db):
    direto = db.execute(
        "SELECT COUNT(*) FROM tickets t LEFT JOIN ticket_comments c ON c.ticket_id = t.id WHERE c.id IS NULL"
    ).fetchone()[0]
    assert len(db.execute(consultas()[3]).fetchall()) == direto
