-- sql-helpdesk-analytics: dados de exemplo (100% fictícios)

INSERT INTO clients (id, name, email, plan, created_at) VALUES
    (1, 'Padaria Estrela',      'contato@padariaestrela.example',  'free',       '2026-07-02'),
    (2, 'Academia Corpo Livre', 'ti@corpolivre.example',           'pro',        '2026-07-15'),
    (3, 'Livraria Paginar',     'suporte@paginar.example',         'free',       '2026-08-01'),
    (4, 'Transportes Rocha',    'operacao@transportesrocha.example','enterprise','2026-08-20'),
    (5, 'Studio Decora',        'oi@studiodecora.example',         'pro',        '2026-09-05'),
    (6, 'Mercado Bom Preço',    'sistemas@bompreco.example',       'enterprise', '2026-09-30');

INSERT INTO agents (id, name, email, team) VALUES
    (1, 'Ana Siqueira',  'ana@helpdesk.example',  'suporte'),
    (2, 'Bruno Tavares', 'bruno@helpdesk.example','suporte'),
    (3, 'Carla Nunes',   'carla@helpdesk.example','sucesso do cliente');

INSERT INTO tickets (id, client_id, agent_id, subject, status, priority, created_at, resolved_at) VALUES
    (1,  1, 1,    'Não consigo emitir relatório mensal',        'fechado',      'media',   '2026-10-01', '2026-10-02'),
    (2,  2, 1,    'Erro 500 ao salvar configurações',           'resolvido',    'alta',    '2026-10-03', '2026-10-05'),
    (3,  3, 2,    'Dúvida sobre exportação em CSV',             'fechado',      'baixa',   '2026-10-06', '2026-10-06'),
    (4,  4, 2,    'Integração com API retornando timeout',      'em andamento', 'critica', '2026-10-10', NULL),
    (5,  4, 1,    'Usuários sem permissão de acesso',           'resolvido',    'alta',    '2026-10-12', '2026-10-13'),
    (6,  5, 3,    'Alterar e-mail do administrador',            'fechado',      'baixa',   '2026-10-15', '2026-10-15'),
    (7,  2, 3,    'Cobrança duplicada na fatura',               'resolvido',    'alta',    '2026-10-18', '2026-10-21'),
    (8,  6, 2,    'Lentidão no painel pela manhã',              'em andamento', 'media',   '2026-10-25', NULL),
    (9,  1, 1,    'Como resetar senha de operador',             'fechado',      'baixa',   '2026-10-28', '2026-10-28'),
    (10, 3, NULL, 'Sugestão: tema escuro no app',               'aberto',       'baixa',   '2026-11-02', NULL),
    (11, 5, 3,    'Webhook não dispara em novos pedidos',       'resolvido',    'alta',    '2026-11-05', '2026-11-09'),
    (12, 6, 2,    'Falha no login após atualização',            'resolvido',    'critica', '2026-11-08', '2026-11-08'),
    (13, 4, 1,    'Relatório de novembro com dados zerados',    'aberto',       'alta',    '2026-11-15', NULL),
    (14, 2, NULL, 'Dúvida sobre limite do plano pro',           'aberto',       'media',   '2026-11-18', NULL);

INSERT INTO ticket_comments (id, ticket_id, author_type, body, created_at) VALUES
    (1,  1,  'cliente', 'O botão de exportar não responde.',              '2026-10-01'),
    (2,  1,  'agente',  'Identifiquei o problema, liberando correção.',   '2026-10-01'),
    (3,  1,  'cliente', 'Funcionou, obrigado!',                           '2026-10-02'),
    (4,  2,  'cliente', 'Segue print do erro 500.',                       '2026-10-03'),
    (5,  2,  'agente',  'Reproduzi aqui, escalei para engenharia.',       '2026-10-03'),
    (6,  2,  'agente',  'Correção publicada, pode validar?',              '2026-10-05'),
    (7,  3,  'agente',  'Enviei o passo a passo da exportação.',          '2026-10-06'),
    (8,  4,  'cliente', 'Timeout continua desde ontem.',                  '2026-10-10'),
    (9,  4,  'agente',  'Aumentamos o timeout, monitorando.',             '2026-10-11'),
    (10, 4,  'cliente', 'Ainda ocorre às 9h.',                            '2026-10-12'),
    (11, 5,  'agente',  'Ajustei as permissões do grupo.',                '2026-10-12'),
    (12, 5,  'cliente', 'Acesso normalizado.',                            '2026-10-13'),
    (13, 6,  'cliente', 'Preciso trocar o e-mail do admin.',              '2026-10-15'),
    (14, 6,  'agente',  'E-mail alterado e confirmado.',                  '2026-10-15'),
    (15, 7,  'cliente', 'Fatura veio com duas cobranças.',                '2026-10-18'),
    (16, 7,  'agente',  'Estorno solicitado ao financeiro.',              '2026-10-19'),
    (17, 7,  'agente',  'Estorno concluído.',                             '2026-10-21'),
    (18, 8,  'cliente', 'Painel lento das 8h às 10h.',                    '2026-10-25'),
    (19, 8,  'agente',  'Coletando métricas do período.',                 '2026-10-26'),
    (20, 9,  'agente',  'Enviei o link de redefinição.',                  '2026-10-28'),
    (21, 11, 'cliente', 'Webhook parou após mudança de URL.',             '2026-11-05'),
    (22, 11, 'agente',  'URL atualizada e testada.',                      '2026-11-09'),
    (23, 12, 'cliente', 'Ninguém consegue logar!',                        '2026-11-08'),
    (24, 12, 'agente',  'Rollback feito, login restabelecido.',           '2026-11-08'),
    (25, 13, 'cliente', 'O relatório de novembro veio vazio.',            '2026-11-15');
