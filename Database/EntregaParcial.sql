/****
 * Desafio 2
 * Entrega parcial
 */

-- Primeiramente atualizaria incluiria mais um status de pedido
INSERT INTO StatusPedido (IdStatus, Nome, Ordem) VALUES (9, 'Parcialmente entregue', 7)

-- Mudar a ordem do status de cancelado para 8 para ajustar a ordem
UPDATE StatusPedido SET Ordem = 8 WHERE IdStatus = 8

-- Incluiria mais um campo na tabela ItemPedido para "flegar" como entregue o produto
ALTER TABLE ItemPedido ADD Entregue bit default 0;

-- No controle de entrega só vai atualizar para entregue se todos os itens da tabela ItemPedido estivem true
-- E será disponibilizado um Endpoint para que isso possa ser solucionado
