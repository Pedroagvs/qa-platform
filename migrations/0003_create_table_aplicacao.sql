CREATE TABLE IF NOT EXISTS qa_prime. tb_aplicacao (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(30) NOT NULL,
dataCadastro  DATE DEFAULT (CURRENT_DATE()),
plataforma VARCHAR(30) NOT NULL
);