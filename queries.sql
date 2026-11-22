-- sql-helpdesk-analytics: consultas de análise
-- Sintaxe SQLite. Para PostgreSQL, trocar julianday(a) - julianday(b) por (a::date - b::date)
-- e strftime('%Y-%m', data) por to_char(data::date, 'YYYY-MM').

-- 1) Tickets abertos/em andamento por prioridade (CASE + filtro)
SELECT priority,
       COUNT(*) AS total
FROM tickets
WHERE status IN ('aberto', 'em andamento')
GROUP BY priority
ORDER BY CASE priority
             WHEN 'critica' THEN 1
             WHEN 'alta'    THEN 2
             WHEN 'media'   THEN 3
             ELSE 4
         END;

-- 2) Tempo médio de resolução por agente, em dias (JOIN + agregação)
SELECT a.name AS agente,
       COUNT(t.id) AS resolvidos,
       ROUND(AVG(julianday(t.resolved_at) - julianday(t.created_at)), 1) AS media_dias
FROM tickets t
JOIN agents a ON a.id = t.agent_id
WHERE t.resolved_at IS NOT NULL
GROUP BY a.name
ORDER BY media_dias;

-- 3) Clientes com mais de 2 tickets (JOIN + GROUP BY + HAVING)
SELECT c.name AS cliente,
       c.plan,
       COUNT(t.id) AS total_tickets
FROM clients c
JOIN tickets t ON t.client_id = c.id
GROUP BY c.id
HAVING COUNT(t.id) > 2
ORDER BY total_tickets DESC;

-- 4) Tickets sem nenhum comentário (NOT EXISTS)
SELECT t.id, t.subject, t.status
FROM tickets t
WHERE NOT EXISTS (
    SELECT 1
    FROM ticket_comments tc
    WHERE tc.ticket_id = t.id
);

-- 5) Ranking de agentes por tickets resolvidos (função de janela RANK)
SELECT a.name AS agente,
       COUNT(t.id) AS resolvidos,
       RANK() OVER (ORDER BY COUNT(t.id) DESC) AS posicao
FROM agents a
LEFT JOIN tickets t ON t.agent_id = a.id AND t.resolved_at IS NOT NULL
GROUP BY a.id
ORDER BY posicao;

-- 6) Média de comentários por ticket, por status (CTE)
WITH comentarios AS (
    SELECT ticket_id, COUNT(*) AS total
    FROM ticket_comments
    GROUP BY ticket_id
)
SELECT t.status,
       ROUND(AVG(c.total), 1) AS media_comentarios
FROM tickets t
JOIN comentarios c ON c.ticket_id = t.id
GROUP BY t.status;

-- 7) Idade dos tickets abertos, classificada (CASE + data de referência)
SELECT t.id,
       t.subject,
       julianday('2026-11-22') - julianday(t.created_at) AS dias_aberto,
       CASE
           WHEN julianday('2026-11-22') - julianday(t.created_at) > 30 THEN 'estourado'
           WHEN julianday('2026-11-22') - julianday(t.created_at) > 7  THEN 'atenção'
           ELSE 'recente'
       END AS classificacao
FROM tickets t
WHERE t.resolved_at IS NULL
ORDER BY dias_aberto DESC;

-- 8) Tickets com mais comentários que a média (subconsulta)
SELECT t.id, t.subject, COUNT(tc.id) AS comentarios
FROM tickets t
JOIN ticket_comments tc ON tc.ticket_id = t.id
GROUP BY t.id
HAVING COUNT(tc.id) > (
    SELECT AVG(total) FROM (
        SELECT COUNT(*) AS total
        FROM ticket_comments
        GROUP BY ticket_id
    )
)
ORDER BY comentarios DESC;

-- 9) Taxa de resolução por plano do cliente (agregação condicional)
SELECT c.plan,
       COUNT(*) AS total,
       SUM(CASE WHEN t.resolved_at IS NOT NULL THEN 1 ELSE 0 END) AS resolvidos,
       ROUND(100.0 * SUM(CASE WHEN t.resolved_at IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_resolvidos
FROM tickets t
JOIN clients c ON c.id = t.client_id
GROUP BY c.plan
ORDER BY pct_resolvidos DESC;

-- 10) Visão cruzada: quantidade por status e prioridade (CASE como pivô)
SELECT priority,
       SUM(CASE WHEN status = 'aberto'       THEN 1 ELSE 0 END) AS abertos,
       SUM(CASE WHEN status = 'em andamento' THEN 1 ELSE 0 END) AS em_andamento,
       SUM(CASE WHEN status = 'resolvido'    THEN 1 ELSE 0 END) AS resolvidos,
       SUM(CASE WHEN status = 'fechado'      THEN 1 ELSE 0 END) AS fechados
FROM tickets
GROUP BY priority
ORDER BY abertos + em_andamento DESC;

-- 11) Tickets criados por mês (função de data)
SELECT strftime('%Y-%m', created_at) AS mes,
       COUNT(*) AS total
FROM tickets
GROUP BY mes
ORDER BY mes;

-- 12) Primeira resposta do agente por ticket (função de janela ROW_NUMBER)
WITH respostas AS (
    SELECT tc.ticket_id,
           tc.created_at,
           ROW_NUMBER() OVER (PARTITION BY tc.ticket_id ORDER BY tc.created_at) AS ordem
    FROM ticket_comments tc
    WHERE tc.author_type = 'agente'
)
SELECT t.id,
       t.subject,
       r.created_at AS primeira_resposta
FROM tickets t
JOIN respostas r ON r.ticket_id = t.id AND r.ordem = 1
ORDER BY t.id;
