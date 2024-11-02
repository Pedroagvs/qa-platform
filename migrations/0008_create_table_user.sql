

CREATE TABLE IF NOT EXISTS  tb_user (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
email VARCHAR(30) NOT NULL,
dataCadastro  DATE DEFAULT (CURRENT_DATE()),
senha CHAR(32) NOT NULL,
cargo VARCHAR(32) NOT NULL,
thumbnail MEDIUMBLOB
);

INSERT INTO tb_user (nome,email,senha,cargo) VALUES ('Admin','admin@gmail.com','md5(senha123)','Administrador');
INSERT INTO tb_user (nome,email,senha,cargo) VALUES ('tester','tester@gmail.com','md5(senha123)','Tester');
INSERT INTO tb_user (nome,email,senha,cargo) VALUES ('desenvolvedor','dev@gmail.com','md5(senha123)','Desenvolvedor');
