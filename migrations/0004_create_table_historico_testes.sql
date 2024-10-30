CREATE TABLE IF NOT EXISTS qa_prime. tb_historico (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
criador VARCHAR(30) NOT NULL,
fonte VARCHAR(30) NOT NULL,
descricao TEXT ,
dataCadastro  DATE DEFAULT (CURRENT_DATE()),
fechado BOOLEAN DEFAULT false,
aplicacao_id INT(6) UNSIGNED NOT NULL,
constraint foreign key (aplicacao_id) references tb_aplicacao(id) ON DELETE CASCADE
);