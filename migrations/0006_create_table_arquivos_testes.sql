CREATE TABLE IF NOT EXISTS qa_prime. tb_arquivos_teste(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
dataCadastro  DATE DEFAULT (CURRENT_DATE()),
nome VARCHAR(255),
bytes MEDIUMBLOB,
testes_id INT(6) UNSIGNED NOT NULL,
constraint foreign key (testes_id) references tb_testes(id) ON DELETE CASCADE
);