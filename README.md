# Processando XML - Desafio

### Informações gerais
- ruby v3.3.1
- rails v7.2.0
- bundler v2.5.10
- redis v7.4.0
- sidekiq v7.3.1

### O que foi implementado:

- Autenticação de Usuário
- Upload de Documentos
- Processamento em Background
- Relatório
  - Dados do Documento Fiscal: Número de Série (serie), Número da Nota Fiscal (nNF), Data e Hora de Emissão (dhEmi), Dados do Emitente (emit) e do Destinatário (dest).
  - Produtos Listados: Nome (xProd), NCM (NCM), CFOP (CFOP), Unidade Comercializada (uCom), Quantidade Comercializada (qCom), Valor Unitário (vUnCom).
  - Impostos Associados: Valor do ICMS (vICMS), Valor do IPI (vIPI), Valor do PIS (vPIS), Valor do COFINS (vCOFINS).
  - Totalizadores: Resumo dos valores totais dos produtos e impostos.
- Filtros
- Testes automatizados utilizando RSPEC para as funcionalidades principais.

### Link de hospedagem do projeto
[Heroku app](https://arcane-taiga-49369-8d4a3ed4eb54.herokuapp.com/)

Para acessar ⤵️
- email: andre@dedev.lab
- senha: 123456
