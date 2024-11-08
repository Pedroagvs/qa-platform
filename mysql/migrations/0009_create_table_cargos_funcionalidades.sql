CREATE TABLE IF NOT EXISTS tb_cargo_funcionalidades (
    cargo_id INT(6) UNSIGNED NOT NULL,
    funcionalidade_id INT(6) UNSIGNED NOT NULL,
    PRIMARY KEY (cargo_id, funcionalidade_id),
    FOREIGN KEY (cargo_id) REFERENCES tb_cargos(id),
    FOREIGN KEY (funcionalidade_id) REFERENCES tb_funcionalidades(id)
);

