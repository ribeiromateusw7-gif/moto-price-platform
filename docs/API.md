
# Documentação da API — Moto Price Platform

## 1. Visão geral

A API será responsável por conectar a interface da plataforma ao banco de dados e aos serviços internos.

Tecnologia recomendada: NestJS + TypeScript.

Estilo: REST API.

Prefixo inicial:

/api/v1

Formato de dados: JSON.

Autenticação: Bearer Token.

## 2. Padrão de resposta

Resposta de sucesso:

```json
{
  "success": true,
  "data": {},
  "message": "Operação realizada com sucesso"
}
```

Resposta de erro:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Dados inválidos"
  }
}
```

## 3. Autenticação

### Registrar usuário

POST /api/v1/auth/register

Exemplo:

```json
{
  "fullName": "João Silva",
  "email": "joao@email.com",
  "password": "senha_segura"
}
```

### Iniciar sessão

POST /api/v1/auth/login

### Consultar usuário autenticado

GET /api/v1/auth/me

### Encerrar sessão

POST /api/v1/auth/logout

A autenticação deverá validar tokens e permissões no servidor.

## 4. Catálogo de produtos

### Listar produtos

GET /api/v1/products

Parâmetros:

- q: termo de pesquisa.
- brandId: identificador da marca.
- categoryId: identificador da categoria.
- page: página.
- limit: quantidade de resultados.

### Consultar produto

GET /api/v1/products/{productId}

### Criar produto

POST /api/v1/products

Apenas usuários autorizados.

### Atualizar produto

PATCH /api/v1/products/{productId}

### Listar marcas

GET /api/v1/brands

### Listar categorias

GET /api/v1/categories

## 5. Pesquisa de produtos

### Pesquisa textual

GET /api/v1/search

Parâmetros:

- q: texto pesquisado.
- motorcycleId: motocicleta selecionada.
- latitude: latitude do consumidor, quando autorizada.
- longitude: longitude do consumidor, quando autorizada.
- radiusKm: raio de pesquisa.
- sort: critério de ordenação.
- page: página.
- limit: quantidade de resultados.

Exemplo:

GET /api/v1/search?q=pastilha%20de%20freio

### Pesquisa por fotografia

POST /api/v1/search/image

Content-Type: multipart/form-data

Campos:

- image: arquivo de imagem.
- motorcycleId: identificador opcional da motocicleta.

A API deverá validar o arquivo, armazená-lo de forma segura e iniciar o processamento visual.

A resposta poderá informar que o processamento está pendente.

### Consultar processamento da imagem

GET /api/v1/search/image/{jobId}

## 6. Ofertas e comparação

### Listar ofertas de um produto

GET /api/v1/products/{productId}/offers

Parâmetros:

- latitude.
- longitude.
- radiusKm.
- sort.
- page.
- limit.

### Comparar ofertas

GET /api/v1/compare/{productId}

A resposta deverá apresentar:

- Produto canônico.
- Loja.
- Preço.
- Disponibilidade.
- Quantidade, quando conhecida.
- Distância estimada, quando disponível.
- Data da última atualização.
- Origem da informação.

Não apresentar estoque desconhecido como disponível.

## 7. Motocicletas e compatibilidade

### Listar motocicletas

GET /api/v1/motorcycles

Parâmetros:

- manufacturer.
- model.
- year.

### Consultar motocicleta

GET /api/v1/motorcycles/{motorcycleId}

### Consultar compatibilidade

GET /api/v1/products/{productId}/compatibility

A resposta deverá distinguir compatibilidade verificada de não verificada.

## 8. Lojas

### Cadastrar loja

POST /api/v1/stores

### Consultar loja

GET /api/v1/stores/{storeId}

### Atualizar loja

PATCH /api/v1/stores/{storeId}

### Listar ofertas da loja

GET /api/v1/stores/{storeId}/offers

Acesso às operações de gerenciamento deverá respeitar as permissões dos membros da loja.

## 9. Gerenciamento de ofertas pelo lojista

### Criar oferta

POST /api/v1/stores/{storeId}/offers

Exemplo:

```json
{
  "productId": "UUID_DO_PRODUTO",
  "storeSku": "PAST-001",
  "price": 89.90,
  "currency": "BRL",
  "availability": "in_stock",
  "quantity": 5
}
```

### Atualizar oferta

PATCH /api/v1/stores/{storeId}/offers/{offerId}

### Desativar oferta

DELETE /api/v1/stores/{storeId}/offers/{offerId}

A exclusão deverá preservar o histórico comercial conforme a política de retenção.

## 10. Integrações comerciais

### Criar integração

POST /api/v1/stores/{storeId}/integrations

### Listar integrações

GET /api/v1/stores/{storeId}/integrations

### Consultar integração

GET /api/v1/integrations/{integrationId}

### Testar integração

POST /api/v1/integrations/{integrationId}/test

### Executar sincronização

POST /api/v1/integrations/{integrationId}/sync

### Consultar histórico

GET /api/v1/integrations/{integrationId}/runs

Operações de sincronização devem ser idempotentes e executadas por processamento assíncrono quando necessário.

## 11. Importação de arquivos

POST /api/v1/stores/{storeId}/imports

Formatos previstos:

- CSV.
- XML.

O sistema deverá validar o conteúdo antes de atualizar as ofertas.

## 12. Administração

### Listar lojas pendentes

GET /api/v1/admin/stores/pending

### Aprovar loja

POST /api/v1/admin/stores/{storeId}/approve

### Suspender loja

POST /api/v1/admin/stores/{storeId}/suspend

### Revisar produto

POST /api/v1/admin/products/{productId}/review

Todas as operações administrativas deverão gerar registros de auditoria.

## 13. Segurança da API

Implementar:

- Autenticação obrigatória nas rotas privadas.
- Autorização baseada em funções e recursos.
- Validação de entrada.
- Rate limiting.
- Proteção contra upload malicioso.
- CORS restritivo.
- Logs sem exposição de segredos.
- Paginação.
- Limites de tamanho de requisição.
- Proteção contra acesso indevido entre lojas.

## 14. Versionamento

A primeira versão será:

/api/v1

Alterações incompatíveis deverão utilizar uma nova versão.

## 15. Documentação

A API deverá possuir documentação OpenAPI/Swagger atualizada.

Os contratos documentados devem corresponder às rotas realmente implementadas e testadas.

## 16. Observação de implementação

Este documento especifica as rotas planejadas. Ele não significa que essas rotas já existem.

Cada endpoint deverá ser implementado, validado e testado antes de ser considerado disponível.
