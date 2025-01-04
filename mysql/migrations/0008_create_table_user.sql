

CREATE TABLE IF NOT EXISTS  tb_user (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
email VARCHAR(30) NOT NULL,
dataCadastro  DATE DEFAULT (CURRENT_DATE()),
senha CHAR(32) NOT NULL,
cargo VARCHAR(32) NOT NULL,
thumbnail MEDIUMBLOB
);

INSERT INTO tb_user (nome, email, senha, cargo)
SELECT 'Admin', 'admin@gmail.com', md5('senha123'), 'Administrador'
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE email = 'admin@gmail.com');

INSERT INTO tb_user (nome, email, senha, cargo)
SELECT 'tester', 'tester@gmail.com', md5('senha123'), 'Tester'
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE email = 'tester@gmail.com');

INSERT INTO tb_user (nome, email, senha, cargo)
SELECT 'desenvolvedor', 'dev@gmail.com', md5('senha123'), 'Desenvolvedor'
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE email = 'dev@gmail.com');


