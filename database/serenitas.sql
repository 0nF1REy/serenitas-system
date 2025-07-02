CREATE SCHEMA IF NOT EXISTS serenitas_db 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE serenitas_db;

CREATE TABLE IF NOT EXISTS tb_produto (
    id_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    marca VARCHAR(50),
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    INDEX idx_deleted_at (deleted_at),
    INDEX idx_nome (nome),
    INDEX idx_marca (marca)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SHOW TABLES;

-- DESC tb_produto;

-- INSERT INTO tb_produto (nome, marca, preco) 
-- VALUES ('TV', 'Toshiba', 1500.00);

-- INSERT INTO tb_produto (nome, marca, preco) 
-- VALUES ('Notebook', 'Dell', 3499.90);

-- DELETE FROM tb_produto WHERE id_produto = 1;

-- SELECT * FROM tb_produto;

-- SELECT * FROM tb_produto WHERE nome LIKE "%No%";

-- DROP DATABASE serenitas_db;

