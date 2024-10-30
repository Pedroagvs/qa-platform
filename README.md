![Badge em Desenvolvimento](http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge)

 * Dashboard.
 * Cache Usuário.
 * Download Relatórios
 * Bloqueio de funcionalidades por cargo.
 * JWT para as APIS 

# Quality Assurance Platform - (QA-Platform)

### Índice

* [Descrição do Projeto](#descrição-do-projeto)
* [Estrutura do Projeto](#estrutura-do-projeto)


## Descrição do Projeto
A plataforma Quality Assurance é um site voltado para a gestão de casos de teste de aplicações, permitindo que os QAs registrem tickets para bugs, melhorias e erros encontrados durante o processo de testes. Além disso, fornece aos desenvolvedores um histórico detalhado dos testes realizados na aplicação, facilitando o acompanhamento e a resolução de problemas.


## Estrutura do Projeto
 * Front end : A construção das telas foi realizada utilizando o flutter e o dart.
    - Gerenciamento de Estado : Asp
    - Navegação : RouteFly
 
 * Backend : A construção do back-end do projeto foi feita utilizando o dart e shelf com banco de dados mySQL.
    - Servidor : shelf
    - DB : MySQL
  

## Como instalar
  1 - Realize o donwload e instale o Flutter.
  2 - Realize o donwload e instale o MySQl.
  3 - Realize o donwload e instale o Docker.
  4 - Abra e execute na raiz do projeto 'docker compose up'
  5 - cd app && flutter build web
  6 - cd back_end dart run
  7 - Abra um browser e insira 'http://127.0.0.1:8000/'