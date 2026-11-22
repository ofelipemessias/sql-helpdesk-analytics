-- sql-helpdesk-analytics: esquema
-- Banco de exemplo de um sistema de helpdesk: clientes, agentes, tickets e comentários.
-- Compatível com SQLite e PostgreSQL. Dados 100% fictícios.

DROP TABLE IF EXISTS ticket_comments;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS agents;

CREATE TABLE clients (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL UNIQUE,
    plan        TEXT    NOT NULL CHECK (plan IN ('free', 'pro', 'enterprise')),
    created_at  TEXT    NOT NULL  -- data ISO: YYYY-MM-DD
);

CREATE TABLE agents (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL UNIQUE,
    team        TEXT    NOT NULL CHECK (team IN ('suporte', 'sucesso do cliente', 'engenharia'))
);

CREATE TABLE tickets (
    id            INTEGER PRIMARY KEY,
    client_id     INTEGER NOT NULL REFERENCES clients (id),
    agent_id      INTEGER          REFERENCES agents (id),  -- NULL = ainda não atribuído
    subject       TEXT    NOT NULL,
    status        TEXT    NOT NULL CHECK (status IN ('aberto', 'em andamento', 'resolvido', 'fechado')),
    priority      TEXT    NOT NULL CHECK (priority IN ('baixa', 'media', 'alta', 'critica')),
    created_at    TEXT    NOT NULL,  -- data ISO
    resolved_at   TEXT               -- NULL enquanto não resolvido
);

CREATE TABLE ticket_comments (
    id          INTEGER PRIMARY KEY,
    ticket_id   INTEGER NOT NULL REFERENCES tickets (id),
    author_type TEXT    NOT NULL CHECK (author_type IN ('cliente', 'agente')),
    body        TEXT    NOT NULL,
    created_at  TEXT    NOT NULL
);
