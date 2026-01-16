-- ===============================
-- BANCO DE DADOS
-- ===============================
-- CREATE DATABASE IF NOT EXISTS orders_db
--   CHARACTER SET utf8mb4
--   COLLATE utf8mb4_unicode_ci;

USE orders_db;

-- ===============================
-- PERFIL
-- ===============================
CREATE TABLE perfil (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

-- ===============================
-- PERMISSAO
-- ===============================
CREATE TABLE permissao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

-- ===============================
-- ACESSO (perfil x permissao)
-- ===============================
CREATE TABLE acesso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_perfil INT NOT NULL,
    id_permissao INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_acesso_perfil
        FOREIGN KEY (id_perfil) REFERENCES perfil(id),
    CONSTRAINT fk_acesso_permissao
        FOREIGN KEY (id_permissao) REFERENCES permissao(id)
);

-- ===============================
-- USUARIO
-- ===============================
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    email_verified_at TIMESTAMP NULL DEFAULT NULL,
    senha VARCHAR(100) NOT NULL,
    id_perfil INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_usuario_perfil
        FOREIGN KEY (id_perfil) REFERENCES perfil(id)
);

-- ===============================
-- CATEGORIA
-- ===============================
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

-- ===============================
-- PRODUTO
-- ===============================
CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    valor DOUBLE NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);

-- ===============================
-- PEDIDO
-- ===============================
CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    mesa VARCHAR(20) NULL,
    data DATE NOT NULL,
    observacao LONGTEXT NULL,
    desconto DOUBLE DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- ===============================
-- ITENS PEDIDO
-- ===============================
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_itens_pedido_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    CONSTRAINT fk_itens_pedido_produto
        FOREIGN KEY (id_produto) REFERENCES produto(id)
);

-- ===============================
-- PAGAMENTO PEDIDO
-- ===============================
CREATE TABLE pagamento_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    valor_pagamento DOUBLE NOT NULL,
    tipo_pagamento VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_pagamento_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);

-- ===============================
-- LOGS
-- ===============================
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    acao VARCHAR(50) NOT NULL,
    arquivos VARCHAR(255),
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_logs_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- ===============================
-- PERFIL PADRÃO (ADMIN)
-- ===============================
INSERT INTO perfil (id, nome)
VALUES (1, 'Administrador');

-- ===============================
-- USUÁRIO PADRÃO DO SISTEMA
-- ===============================
INSERT INTO usuario (
    nome,
    email,
    email_verified_at,
    senha,
    id_perfil,
    created_at
) VALUES (
    'Usuário Sistema',
    'attini@system.com.br',
    NOW(),
    '$2y$10$2hQ6yV1N1fKJv6wZp0vKle8nG5kLZtZy9bZ1xU4N0r9Yp6nFv8y.e',
    1,
    NOW()
);
