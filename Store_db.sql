	CREATE DATABASE store_db;
    USE store_db;
    
    CREATE TABLE usuario_tb(
     id_usuario INT PRIMARY KEY AUTO_INCREMENT,
     nome_usuario VARCHAR(100) NOT NULL,
     email_usuario VARCHAR(100) UNIQUE NOT NULL,
     senha_usuario VARCHAR(255) NOT NULL,
     cargo_usuario ENUM('cliente', 'administrador') NOT NULL,
     criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produto_tb(
 id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao_produto TEXT,
    categoria_produto VARCHAR(50),
    preco_produto DECIMAL(10, 2) NOT NULL,
    quantidade_estoque_produto INT NOT NULL,
    fornecedor_produto VARCHAR(100),
    produto_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

 CREATE TABLE pedidos_tb(
 id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'enviado', 'entregue', 'cancelado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario_tb(id_usuario)
);

CREATE TABLE itens_pedido_tb(
 id_item_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade_itens_produto INT NOT NULL,
    preco_itens_produto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto_tb(id_produto)
);

CREATE TABLE pagamento_tb(
id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento ENUM('cartao_credito', 'boleto', 'pix', 'paypal') NOT NULL,
    valor_pagamento DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);

CREATE TABLE avaliacao_tb(
 id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_produto INT,
    nota_avaliacao INT CHECK (nota_avaliacao BETWEEN 1 AND 5),
    comentario_avaliacao TEXT,
    avaliacao_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario_tb(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produto_tb(id_produto)
);

CREATE TABLE entrega_tb(
id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    endereco_entrega VARCHAR(255) NOT NULL,
    status_entrega ENUM('pendente', 'enviado', 'entregue') NOT NULL,
    data_entrega TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);

INSERT INTO usuario_tb (nome_usuario, email_usuario, senha_usuario, cargo_usuario) VALUES
('Ana Francisca', 'anaf@ecommerce.com', 'AnaF123', 'administrador'),
('Bartolomeu Dias', 'BartDias1@ecommerce.com', 'DiasBart123', 'cliente'),
('Cezar Augusto', 'cezaaaar@ecommerce.com', 'Augusto123', 'cliente');

INSERT INTO produto_tb(nome_produto, descricao_produto, categoria_produto, preco_produto, quantidade_estoque_produto, fornecedor_produto)VALUES
('Camisa', 'Descrição do produto ccamisa', 'ROUPA', 19.90, 50, 'Fornecedor Chinês'),
('Bermuda', 'Descrição do produto Bermuda', 'ROUPA', 49.90, 30, 'Fornecedor Tailândes'),
('Calça', 'Descrição do produto Calça', 'ROUPA', 99.90, 100, 'Fornecedor Paquistanês');

INSERT INTO pedidos_tb(id_usuario, data_pedido, status) VALUES
(2, '2025-03-01', 'pendente'),
(3, '2025-03-13', 'enviado'),
(1, '2025-03-07', 'entregue'),
(2, '2025-03-15', 'enviado');







