![Badge em Desenvolvimento](http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge)

 * Download Relatórios
 * JWT para as APIS 

# Quality Assurance Platform - (QA-Platform)

### Índice

* [Descrição do Projeto](#descrição-do-projeto)
* [Estrutura do Projeto](#estrutura-do-projeto)


## Descrição do Projeto
A plataforma Quality Assurance é um site voltado para a gestão de casos de teste de aplicações, permitindo que os QAs registrem tickets para bugs, melhorias e erros encontrados durante o processo de testes. Além disso, fornece aos desenvolvedores um histórico detalhado dos testes realizados na aplicação, facilitando o acompanhamento e a resolução de problemas.


## Estrutura do Projeto
 * Front end : A construção das telas foi realizada utilizando o flutter e o dart.
    - Gerenciamento de Estado : ASP 
    - Navegação : RouteFly
 
 * Backend : A construção do back-end do projeto foi feita utilizando o dart e shelf com banco de dados mySQL.
    - Servidor : shelf
    - DB : MySQL
  

## Como instalar
  *  Realize o donwload e instale o Flutter.
  *  Realize o donwload e instale o MySQl.
  *  Realize o donwload e instale o Docker.
  *  Abra o projeto e execute 'cd mysql && docker compose up'
  *  Volte para raiz e 'cd app && flutter build web'
  *  Volte para raiz cd back_end dart run
  *  Abra um browser e insira 'http://127.0.0.1:8000/'

## Defina em .vscode
```
    FRONT 
     {
            "name": "Front - Debug",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "app/lib/main.dart",
            "args": [
                "--dart-define",
                "SERVER_URL=http://127.0.0.1:8000"
            ]
        },
```
    BACK - END
    {
            "name": "Server - Debug",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "back_end/bin/server.dart",
            "env": {
                "HOST": "localhost",
                "PORT": "3306",
                "USER": "admin",
                "PASSWORD": "123456",
                "DB_NAME": "db_mysql"
            }
        },
