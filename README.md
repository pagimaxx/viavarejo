# Via Varejo
## Aplicação de rastreio de pedidos

Uma aplicação POC do sistema de rastreio de pedidos de produtos conforme proposto em teste.


Estrutura das pastas:

- Database
  - Contém os script's do banco de dados
- FrontendTrackingViaVarejo/frontend
  - Contém o frontend da aplicação
  - Desenvolvido com VueJS 2 acessando uma API com Axios
- JobsHangfire 
  - Projeto .NET Core com um POC de uma aplicação que executa Jobs pre-definidos, justamente para tentar antecipar o problema sistemico
- Demais pasta são de uma solução .NET Core que contempla o backend da aplicação:
  - Webapi com interface com Swagger
  - DDD
  - Injeção de Dependência
  - Repository Pattern
  - Dapper como ORM
  - Banco de dados MSSQL
