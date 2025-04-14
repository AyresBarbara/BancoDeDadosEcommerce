CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE vendas (
    id INT PRIMARY KEY,
    cliente_id INT,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_venda (
    id INT PRIMARY KEY,
    venda_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (venda_id) REFERENCES vendas(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE avaliacoes (
    id INT PRIMARY KEY,
    produto_id INT,
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO produtos (id, nome, preco, estoque) VALUES
(1, 'Notebook', 3000.00, 5),
(2, 'Mouse', 50.00, 100),
(3, 'Teclado', 100.00, 80),
(4, 'Monitor', 800.00, 10);

INSERT INTO clientes (id, nome, email) VALUES
(1, 'João Silva', 'joao@gmail.com'),
(2, 'Maria Souza', 'maria@gmail.com'),
(3, 'Carlos Lima', 'carlos@gmail.com');

INSERT INTO vendas (id, cliente_id, data_venda) VALUES
(1, 1, '2025-03-10'),
(2, 2, '2025-03-15'),
(3, 1, '2025-04-01'),
(4, 3, '2025-04-10');

INSERT INTO itens_venda (id, venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 1, 3000.00),
(2, 2, 2, 2, 50.00),
(3, 2, 3, 1, 100.00),
(4, 3, 2, 5, 45.00),
(5, 4, 1, 1, 2900.00),
(6, 4, 4, 1, 800.00);

INSERT INTO avaliacoes (id, produto_id, nota, comentario) VALUES
(1, 1, 4, 'Muito bom'),
(2, 1, 5, 'Excelente'),
(3, 2, 3, 'Ok'),
(4, 4, 5, 'Imagem excelente');

-- 1. Listar os produtos mais vendidos
SELECT p.nome, SUM(iv.quantidade) AS total_vendido
FROM itens_venda iv
JOIN produtos p ON p.id = iv.produto_id
GROUP BY p.nome
ORDER BY total_vendido DESC;

-- 2. Listar os clientes que mais compraram no último mês
SELECT c.nome, COUNT(v.id) AS total_compras
FROM vendas v
JOIN clientes c ON c.id = v.cliente_id
WHERE v.data_venda >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.nome
ORDER BY total_compras DESC;

-- 3. Verificar o estoque baixo de produtos (estoque < 10)
SELECT nome, estoque
FROM produtos
WHERE estoque < 10;

-- 4. Consultar o faturamento por período (por dia)
SELECT 
    DATE(v.data_venda) AS data,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM vendas v
JOIN itens_venda iv ON iv.venda_id = v.id
GROUP BY DATE(v.data_venda)
ORDER BY data;

-- 5. Obter a média de avaliações de cada produto
SELECT 
    p.nome,
    ROUND(AVG(a.nota), 2) AS media_avaliacao
FROM avaliacoes a
JOIN produtos p ON p.id = a.produto_id
GROUP BY p.nome;

-- 6. Total gasto por cliente
SELECT 
    c.nome,
    SUM(iv.quantidade * iv.preco_unitario) AS total_gasto
FROM clientes c
JOIN vendas v ON c.id = v.cliente_id
JOIN itens_venda iv ON iv.venda_id = v.id
GROUP BY c.nome
ORDER BY total_gasto DESC;
