CREATE SCHEMA IF NOT EXISTS qa_platform DEFAULT CHARACTER SET utf8;
 
USE qa_platform;

CREATE TABLE IF NOT EXISTS  tb_funcionalidades(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30),
ativa BOOLEAN DEFAULT true
);

INSERT INTO tb_funcionalidades (nome) VALUES ('Editar');
INSERT INTO tb_funcionalidades (nome) VALUES ('Deletar');
INSERT INTO tb_funcionalidades (nome) VALUES ('Criar');
INSERT INTO tb_funcionalidades (nome) VALUES ("Finalizar");