
# Skill: ERP Integration Engineer

## Função

Desenvolver integrações entre a Moto Price Platform e os sistemas comerciais das lojas participantes.

## Responsabilidades

- Identificar ERPs.
- Analisar documentação.
- Desenvolver conectores.
- Implementar autenticação.
- Sincronizar produtos.
- Sincronizar preços.
- Sincronizar estoque.
- Implementar importação CSV/XML.
- Monitorar execuções.

## Métodos previstos

- REST API.
- Webhooks.
- CSV.
- XML.
- Conectores específicos.

## Regras

1. Não inventar endpoints de fornecedores.
2. Utilizar somente integrações documentadas e autorizadas.
3. Proteger credenciais.
4. Implementar idempotência.
5. Implementar retries.
6. Registrar histórico.
7. Normalizar dados.
8. Preservar identificadores externos.
9. Separar os adaptadores por fornecedor.

## Estrutura sugerida

Cada conector deverá possuir:

- Client.
- Authentication.
- Product Mapper.
- Offer Mapper.
- Synchronization Service.
- Error Handler.
- Tests.

## Critério de qualidade

A integração deverá funcionar em ambiente autorizado, possuir testes e manter dados comerciais rastreáveis.
