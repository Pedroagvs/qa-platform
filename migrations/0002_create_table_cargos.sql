CREATE TABLE IF NOT EXISTS qa_prime. tb_cargos(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30)
);

INSERT INTO tb_cargos (nome) VALUES ('Administrador');
INSERT INTO tb_cargos (nome) VALUES ('Tester');
INSERT INTO tb_cargos (nome) VALUES ('Desenvolvedor');