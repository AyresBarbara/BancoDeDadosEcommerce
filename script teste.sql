CREATE TABLE usuario_tb (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(100) NOT NULL,
    email_usuario VARCHAR(100) UNIQUE NOT NULL,
    senha_usuario VARCHAR(255) NOT NULL,
    telefone_usuario VARCHAR(15),
    cargo_usuario ENUM('cliente', 'administrador') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categoria_tb (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE fornecedor_tb (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL
);

CREATE TABLE produto_tb (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao_produto TEXT,
    preco_produto DECIMAL(10, 2) NOT NULL,
    quantidade_estoque_produto INT NOT NULL,
    produto_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_categoria INT,
    id_fornecedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria_tb(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor_tb(id_fornecedor)
);

CREATE TABLE pedidos_tb (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'enviado', 'entregue', 'cancelado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario_tb(id_usuario)
);

CREATE TABLE itens_pedido_tb (
    id_pedido INT,
    id_produto INT,
    quantidade_itens_produto INT NOT NULL,
    preco_itens_produto DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto_tb(id_produto)
);

CREATE TABLE pagamento_tb (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento ENUM('cartao_credito', 'boleto', 'pix', 'paypal') NOT NULL,
    valor_pagamento DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);

CREATE TABLE avaliacao_tb (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_produto INT,
    nota_avaliacao INT CHECK (nota_avaliacao BETWEEN 1 AND 5),
    comentario_avaliacao TEXT,
    avaliacao_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario_tb(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produto_tb(id_produto),
    UNIQUE (id_usuario, id_produto)
);

CREATE TABLE entrega_tb (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    endereco_entrega VARCHAR(255) NOT NULL,
    status_entrega ENUM('pendente', 'enviado', 'entregue') NOT NULL,
    data_entrega TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);

INSERT INTO categoria_tb (nome_categoria) VALUES ('Informática'), ('Eletrônicos');

INSERT INTO fornecedor_tb (nome_fornecedor) VALUES ('Dell'), ('Logitech');

INSERT INTO usuario_tb (nome_usuario, email_usuario, senha_usuario, telefone_usuario, cargo_usuario) VALUES
('João Silva', 'joao@email.com', 'senha123', '81999990000', 'cliente'),
('Maria Souza', 'maria@email.com', 'senha456', '81999991111', 'cliente'),
('Admin', 'admin@email.com', 'admin123', '81999992222', 'administrador');

INSERT INTO produto_tb (nome_produto, descricao_produto, preco_produto, quantidade_estoque_produto, id_categoria, id_fornecedor) VALUES
('Notebook', 'Notebook potente', 3500.00, 5, 1, 1),
('Mouse', 'Mouse sem fio', 100.00, 50, 1, 2),
('Teclado', 'Teclado mecânico', 250.00, 20, 1, 2),
('Monitor', 'Monitor Full HD', 900.00, 10, 2, 1);

INSERT INTO pedidos_tb (id_usuario, status) VALUES
(1, 'entregue'),
(2, 'entregue'),
(1, 'pendente');

INSERT INTO itens_pedido_tb (id_pedido, id_produto, quantidade_itens_produto, preco_itens_produto) VALUES
(1, 1, 1, 3500.00),
(1, 2, 2, 95.00),
(2, 3, 1, 240.00),
(2, 2, 1, 100.00),
(3, 4, 1, 900.00);

INSERT INTO pagamento_tb (id_pedido, metodo_pagamento, valor_pagamento) VALUES
(1, 'cartao_credito', 3690.00),
(2, 'pix', 340.00);

INSERT INTO avaliacao_tb (id_usuario, id_produto, nota_avaliacao, comentario_avaliacao) VALUES
(1, 1, 5, 'Notebook excelente!'),
(1, 2, 4, 'Mouse bom, mas poderia ser melhor.'),
(2, 3, 5, 'Teclado top!');

INSERT INTO entrega_tb (id_pedido, endereco_entrega, status_entrega, data_entrega) VALUES
(1, 'Rua A, 123', 'entregue', '2025-04-01'),
(2, 'Rua B, 456', 'entregue', '2025-04-05');

-- 1. Produtos mais vendidos
SELECT p.nome_produto, SUM(ip.quantidade_itens_produto) AS total_vendido
FROM itens_pedido_tb ip
JOIN produto_tb p ON p.id_produto = ip.id_produto
GROUP BY p.nome_produto
ORDER BY total_vendido DESC;

-- 2. Clientes que mais compraram no último mês
SELECT u.nome_usuario, COUNT(ped.id_pedido) AS total_pedidos
FROM pedidos_tb ped
JOIN usuario_tb u ON u.id_usuario = ped.id_usuario
WHERE ped.data_pedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY u.nome_usuario
ORDER BY total_pedidos DESC;

-- 3. Produtos com estoque baixo (< 10 unidades)
SELECT nome_produto, quantidade_estoque_produto
FROM produto_tb
WHERE quantidade_estoque_produto < 10;

-- 4. Faturamento por data
SELECT 
    DATE(p.data_pedido) AS data,
    SUM(ip.quantidade_itens_produto * ip.preco_itens_produto) AS faturamento
FROM pedidos_tb p
JOIN itens_pedido_tb ip ON p.id_pedido = ip.id_pedido
GROUP BY DATE(p.data_pedido)
ORDER BY data;

-- 5. Média de avaliação por produto
SELECT 
    pr.nome_produto,
    ROUND(AVG(av.nota_avaliacao), 2) AS media_avaliacao
FROM avaliacao_tb av
JOIN produto_tb pr ON pr.id_produto = av.id_produto
GROUP BY pr.nome_produto;

-- 6. Total gasto por cliente
SELECT 
    u.nome_usuario,
    SUM(ip.quantidade_itens_produto * ip.preco_itens_produto) AS total_gasto
FROM usuario_tb u
JOIN pedidos_tb p ON u.id_usuario = p.id_usuario
JOIN itens_pedido_tb ip ON p.id_pedido = ip.id_pedido
GROUP BY u.nome_usuario
ORDER BY total_gasto DESC;

