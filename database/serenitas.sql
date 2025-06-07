CREATE SCHEMA IF NOT EXISTS serenitas_db;

USE serenitas_db;

CREATE TABLE IF NOT EXISTS tb_produto (
    codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    marca VARCHAR(50),
    preco DECIMAL(10,2) NOT NULL
);

SHOW TABLES;

INSERT INTO tb_produto (nome, marca, preco) 
VALUES ('TV', 'Toshiba', 1500.00);

INSERT INTO tb_produto (nome, marca, preco) 
VALUES ('Notebook', 'Dell', 3499.90);

DELETE FROM tb_produto WHERE codigo = 1;

SELECT * FROM tb_produto;

DROP DATABASE serenitas_db;

