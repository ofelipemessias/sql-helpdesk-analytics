# 🗄️ SQL Helpdesk Analytics

🌐 [Español](#español) | [English](#english) | [Português](#português)

---

## 🇪🇸 Español

Base de datos de ejemplo de un sistema de **helpdesk** (clientes, agentes, tickets y comentarios) con **12 consultas SQL de análisis**, comentadas una a una. Datos 100% ficticios.

Las consultas practican lo que suelen pedir las entrevistas de QA, soporte y datos:

- ✅ JOINs entre 4 tablas relacionadas
- ✅ Agregaciones con `GROUP BY` + `HAVING`
- ✅ Subconsultas y `NOT EXISTS`
- ✅ CTEs (`WITH`)
- ✅ Funciones de ventana (`RANK`, `ROW_NUMBER`)
- ✅ `CASE` para clasificación y tablas cruzadas
- ✅ Funciones de fecha y filtrado por período

### Estructura

```
├── schema.sql   # Tablas con claves, UNIQUE y CHECK
├── seed.sql     # Datos ficticios: 6 clientes, 3 agentes, 14 tickets, 25 comentarios
└── queries.sql  # 12 consultas comentadas
```

### Ejecutar con SQLite (sin instalar servidor)

```bash
sqlite3 helpdesk.db < schema.sql
sqlite3 helpdesk.db < seed.sql
sqlite3 helpdesk.db < queries.sql
```

### Ejecutar con PostgreSQL

```bash
createdb helpdesk
psql -d helpdesk -f schema.sql -f seed.sql -f queries.sql
```

Las consultas usan sintaxis SQLite para fechas; el propio `queries.sql` indica el equivalente en PostgreSQL.

---

## 🇬🇧 English

Sample database of a **helpdesk system** (clients, agents, tickets and comments) with **12 analysis SQL queries**, each one commented. 100% fictional data.

The queries practice what QA, support and data interviews usually ask for:

- ✅ JOINs across 4 related tables
- ✅ Aggregations with `GROUP BY` + `HAVING`
- ✅ Subqueries and `NOT EXISTS`
- ✅ CTEs (`WITH`)
- ✅ Window functions (`RANK`, `ROW_NUMBER`)
- ✅ `CASE` for classification and cross-tabs
- ✅ Date functions and period filtering

### Project layout

```
├── schema.sql   # Tables with keys, UNIQUE and CHECK constraints
├── seed.sql     # Fictional data: 6 clients, 3 agents, 14 tickets, 25 comments
└── queries.sql  # 12 commented queries
```

### Run with SQLite (no server needed)

```bash
sqlite3 helpdesk.db < schema.sql
sqlite3 helpdesk.db < seed.sql
sqlite3 helpdesk.db < queries.sql
```

### Run with PostgreSQL

```bash
createdb helpdesk
psql -d helpdesk -f schema.sql -f seed.sql -f queries.sql
```

Queries use SQLite date syntax; `queries.sql` itself notes the PostgreSQL equivalent.

---

## 🇧🇷 Português

Banco de dados de exemplo de um sistema de **helpdesk** (clientes, agentes, tickets e comentários) com **12 consultas SQL de análise**, comentadas uma a uma. Dados 100% fictícios.

As consultas praticam o que entrevistas de QA, suporte e dados costumam pedir:

- ✅ JOINs entre 4 tabelas relacionadas
- ✅ Agregações com `GROUP BY` + `HAVING`
- ✅ Subconsultas e `NOT EXISTS`
- ✅ CTEs (`WITH`)
- ✅ Funções de janela (`RANK`, `ROW_NUMBER`)
- ✅ `CASE` para classificação e tabelas cruzadas
- ✅ Funções de data e filtro por período

### Estrutura

```
├── schema.sql   # Tabelas com chaves, UNIQUE e CHECK
├── seed.sql     # Dados fictícios: 6 clientes, 3 agentes, 14 tickets, 25 comentários
└── queries.sql  # 12 consultas comentadas
```

### Rodar com SQLite (sem instalar servidor)

```bash
sqlite3 helpdesk.db < schema.sql
sqlite3 helpdesk.db < seed.sql
sqlite3 helpdesk.db < queries.sql
```

### Rodar com PostgreSQL

```bash
createdb helpdesk
psql -d helpdesk -f schema.sql -f seed.sql -f queries.sql
```

As consultas usam sintaxe de data do SQLite; o próprio `queries.sql` indica o equivalente em PostgreSQL.
