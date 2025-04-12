CREATE DATABASE store_db;
USE store_db;

-- Usuário
CREATE TABLE usuario_tb (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(100) NOT NULL,
    email_usuario VARCHAR(100) UNIQUE NOT NULL,
    senha_usuario VARCHAR(255) NOT NULL,
    telefone_usuario VARCHAR(15),
    cargo_usuario ENUM('cliente', 'administrador') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categoria
CREATE TABLE categoria_tb (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL
);

-- Fornecedor
CREATE TABLE fornecedor_tb (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL
);

-- Produto
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

-- Pedidos
CREATE TABLE pedidos_tb (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'enviado', 'entregue', 'cancelado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario_tb(id_usuario)
);

-- Itens do Pedido (com chave composta)
CREATE TABLE itens_pedido_tb (
    id_pedido INT,
    id_produto INT,
    quantidade_itens_produto INT NOT NULL,
    preco_itens_produto DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto_tb(id_produto)
);

-- Pagamento
CREATE TABLE pagamento_tb (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento ENUM('cartao_credito', 'boleto', 'pix', 'paypal') NOT NULL,
    valor_pagamento DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);

-- Avaliação
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

-- Entrega
CREATE TABLE entrega_tb (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    endereco_entrega VARCHAR(255) NOT NULL,
    status_entrega ENUM('pendente', 'enviado', 'entregue') NOT NULL,
    data_entrega TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES pedidos_tb(id_pedido)
);
