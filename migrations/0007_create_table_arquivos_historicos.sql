CREATE TABLE IF NOT EXISTS qa_prime. tb_arquivos_historicos(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
dataCadastro DATE DEFAULT (CURRENT_DATE()),
nome VARCHAR(255),
bytes MEDIUMBLOB,
historico_id INT(6) UNSIGNED NOT NULL,
constraint foreign key (historico_id) references tb_historico(id) ON DELETE CASCADE
);