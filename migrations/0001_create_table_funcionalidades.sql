CREATE SCHEMA IF NOT EXISTS qa_prime DEFAULT CHARACTER SET utf8;
 
USE qa_prime;

CREATE TABLE IF NOT EXISTS qa_prime. tb_funcionalidades(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30),
ativa BOOLEAN DEFAULT true
);

INSERT INTO tb_funcionalidades (nome) VALUES ('Editar');
INSERT INTO tb_funcionalidades (nome) VALUES ('Deletar');
INSERT INTO tb_funcionalidades (nome) VALUES ('Criar');
INSERT INTO tb_funcionalidades (nome) VALUES ("Finalizar");