CREATE TABLE IF NOT EXISTS tb_usuarios_cargos (
    user_id INT(6) UNSIGNED NOT NULL,
    cargo_id INT(6) UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, cargo_id),
    FOREIGN KEY (user_id) REFERENCES tb_user(id),
    FOREIGN KEY (cargo_id) REFERENCES tb_cargos(id)
);


