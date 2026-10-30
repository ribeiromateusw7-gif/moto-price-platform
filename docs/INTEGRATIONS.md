
# Integrações Comerciais — Moto Price Platform

## 1. Objetivo

Permitir que lojas participantes atualizem automaticamente seus produtos, preços e estoques utilizando sistemas comerciais autorizados.

## 2. Estratégia

Criar um Integration Hub responsável por centralizar a comunicação com sistemas externos.

Cada fornecedor deverá possuir um adaptador independente.

## 3. Tipos de integração

- API REST.
- Webhooks.
- Importação CSV.
- Importação XML.
- Conectores específicos de ERP.
- Outros mecanismos documentados e autorizados.

## 4. Processo de integração de uma loja

1. Identificar o sistema comercial utilizado.
2. Identificar fabricante e versão.
3. Solicitar documentação técnica.
4. Verificar disponibilidade de API.
5. Confirmar autorização de acesso.
6. Obter credenciais de teste.
7. Configurar ambiente de homologação.
8. Mapear campos de produtos, preços e estoque.
9. Implementar adaptador.
10. Executar testes.
11. Validar os dados com a loja.
12. Ativar sincronização de produção.

## 5. Estrutura de um adaptador

Cada adaptador deverá implementar:

- authenticate().
- testConnection().
- fetchProducts().
- fetchPrices().
- fetchStock().
- normalizeProduct().
- normalizeOffer().
- sync().
- handleError().

Os métodos deverão seguir contratos internos padronizados.

## 6. Normalização dos dados

Os sistemas comerciais podem utilizar estruturas diferentes.

A plataforma deverá converter os dados externos para um formato interno padronizado.

Exemplo:

{
  "externalId": "ERP-123",
  "sku": "PAST-001",
  "name": "Pastilha de freio",
  "price": 89.90,
  "currency": "BRL",
  "availability": "in_stock",
  "quantity": 5
}

Esse exemplo representa o formato interno esperado, não um contrato universal de ERP.

## 7. Sincronização

Implementar:

- Sincronização inicial.
- Sincronização incremental.
- Atualização de preços.
- Atualização de estoque.
- Registro de execução.
- Controle de duplicidade.
- Recuperação de falhas.

## 8. Idempotência

A mesma atualização não poderá criar ofertas duplicadas.

Utilizar identificadores externos estáveis e chaves de idempotência quando disponíveis.

## 9. Processamento assíncrono

Utilizar Redis e BullMQ para tarefas demoradas.

Prever:

- Filas por integração.
- Tentativas automáticas.
- Backoff progressivo.
- Dead-letter queue.
- Monitoramento.
- Limites de concorrência.

## 10. Webhooks

Quando disponíveis, os webhooks deverão:

- Validar assinatura.
- Validar origem.
- Rejeitar eventos inválidos.
- Controlar duplicidade.
- Registrar recebimento.
- Processar eventos de forma assíncrona.

## 11. Importação CSV

Disponibilizar modelo de planilha para lojistas sem integração automática.

Campos sugeridos:

- SKU.
- Nome do produto.
- Marca.
- Categoria.
- Código EAN.
- Código do fabricante.
- Preço.
- Quantidade.
- Disponibilidade.

A importação deverá apresentar erros por linha antes de confirmar alterações.

## 12. Importação XML

Criar parsers específicos conforme o formato documentado pelo fornecedor.

Não presumir que todos os arquivos XML possuem o mesmo padrão.

## 13. Segurança

- Credenciais armazenadas em secret manager.
- Nunca registrar senhas nos logs.
- Criptografia em trânsito.
- Controle de permissões.
- Rotação de credenciais.
- Auditoria de sincronizações.
- Isolamento entre lojas.

## 14. Monitoramento

Registrar:

- Última sincronização.
- Resultado.
- Produtos recebidos.
- Produtos criados.
- Produtos atualizados.
- Produtos rejeitados.
- Duração.
- Erros encontrados.

## 15. Frequência de atualização

A frequência deverá ser configurada conforme a capacidade do sistema externo e a autorização da loja.

Não prometer atualização em tempo real quando a integração não oferecer esse recurso.

## 16. Estratégia de implantação

Começar com uma loja parceira e um sistema comercial documentado.

Validar a qualidade dos dados antes de expandir para outros fornecedores.

## 17. Critério de conclusão

Uma integração só poderá ser considerada funcional quando realizar uma sincronização real, autorizada, testada e auditável.
