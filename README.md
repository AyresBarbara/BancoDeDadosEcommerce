# BancoDeDadosEcommerce

# Atividade em Grupo: Modelagem e Implementação de um Banco de Dados para E-commerce

## Objetivo
Os alunos deverão projetar e implementar um banco de dados relacional para um site de e-commerce, contemplando os principais requisitos de um sistema de comércio eletrônico e garantindo a normalização adequada. Além disso, devem realizar consultas SQL que demonstrem o funcionamento do banco.

## Instruções da Atividade

### 1. Formação dos Grupos:
- A turma será dividida em grupos de até 5 integrantes.

### 2. Contexto do Problema:
- O grupo deve projetar um banco de dados para um e-commerce genérico que permita a venda de produtos online.

### 3. Requisitos Funcionais do Banco de Dados
O banco de dados deve contemplar pelo menos as seguintes entidades e funcionalidades:

- **Usuários**: Cadastro de clientes e administradores com diferentes níveis de permissão.
- **Produtos**: Cada produto deve ter nome, descrição, categoria, preço, quantidade em estoque e fornecedor.
- **Pedidos**: Um usuário pode realizar pedidos com múltiplos itens.
- **Pagamentos**: Registro dos pagamentos efetuados (cartão, boleto, PIX, etc.).
- **Entrega**: Endereço de envio e status da entrega.
- **Avaliações**: Usuários podem avaliar produtos.

### 4. Regras de Normalização
- O banco deve estar no mínimo na 3ª Forma Normal (3FN) para evitar redundância e inconsistências.

### 5. Consultas SQL Obrigatórias
O grupo deve elaborar e testar consultas SQL para demonstrar a funcionalidade do sistema, incluindo:

- Listar os produtos mais vendidos.
- Listar os clientes que mais compraram no último mês.
- Verificar o estoque baixo de produtos.
- Consultar o faturamento por período.
- Obter a média de avaliações de cada produto.

---

## CENTRO UNIVERSITÁRIO MAURÍCIO DE NASSAU DE RECIFE/PE
### PROJETO DE BANCO DE DADOS
Prof. Flávio José Ferreira Junior

## EXERCÍCIO

## Modo de Entrega
Os grupos devem entregar um repositório com os seguintes itens:

- Modelo Entidade-Relacionamento (MER) e Modelo Relacional.
- Script SQL de criação do banco (tabelas, chaves primárias e estrangeiras).
- Scripts SQL de inserção de dados simulados.
- Consultas SQL exigidas e outras que julgarem relevantes.
- Relatório explicativo (PDF) detalhando as decisões do projeto.
