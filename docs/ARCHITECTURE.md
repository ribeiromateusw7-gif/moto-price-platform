
# Arquitetura Técnica — Moto Price Platform

## 1. Visão geral

A plataforma será construída inicialmente como um monólito modular, com frontend, API, banco de dados e processamento assíncrono.

## 2. Tecnologias

### Frontend
- Next.js
- React
- TypeScript
- Tailwind CSS

### Backend
- NestJS
- TypeScript
- REST API
- Validação de dados
- Autenticação e autorização

### Banco de dados
- PostgreSQL
- pgvector
- Índices para pesquisa e comparação

### Serviços auxiliares
- Redis
- BullMQ
- Supabase Auth
- Supabase Storage

## 3. Organização dos módulos

O backend deverá possuir os seguintes módulos:

- AuthModule
- UsersModule
- StoresModule
- StoreMembersModule
- CatalogModule
- BrandsModule
- CategoriesModule
- MotorcyclesModule
- CompatibilityModule
- OffersModule
- SearchModule
- ImageSearchModule
- IntegrationsModule
- PricingModule
- AdminModule
- AuditModule

Cada módulo deve possuir responsabilidades bem definidas.

## 4. Fluxo de pesquisa textual

1. O consumidor informa o nome ou código do produto.
2. A API valida a pesquisa.
3. O módulo de catálogo localiza possíveis produtos.
4. O motor de comparação recupera ofertas correspondentes.
5. O sistema verifica preços e disponibilidade.
6. Os resultados são ordenados conforme os filtros.
7. A interface apresenta as lojas e suas ofertas.

## 5. Fluxo de pesquisa por fotografia

1. O consumidor envia uma fotografia.
2. O backend valida formato, tamanho e conteúdo.
3. A imagem é armazenada em local privado.
4. Uma tarefa assíncrona processa a fotografia.
5. O serviço de IA extrai características visuais.
6. O sistema gera embeddings.
7. O pgvector recupera produtos semelhantes.
8. O sistema reordena os candidatos.
9. A interface apresenta possíveis correspondências.

A identificação visual não deve ser tratada como confirmação de compatibilidade.

## 6. Fluxo das lojas

1. O lojista cria sua conta.
2. Solicita aprovação da loja.
3. Um administrador valida os dados.
4. O lojista cadastra ou importa produtos.
5. Os produtos são associados ao catálogo central.
6. As ofertas recebem preço e disponibilidade.
7. O consumidor consegue consultar os dados.

## 7. Integração com sistemas comerciais

O Integration Hub deverá permitir diferentes conectores.

Tipos previstos:

- API REST.
- Webhooks.
- Importação CSV.
- Importação XML.
- Outros formatos autorizados.

Cada integração deve possuir:

- Configuração própria.
- Credenciais protegidas.
- Histórico de execução.
- Tratamento de erros.
- Tentativas automáticas.
- Idempotência.
- Monitoramento.

## 8. Organização sugerida do backend

```text
backend/
  src/
    modules/
      auth/
      users/
      stores/
      catalog/
      motorcycles/
      compatibility/
      offers/
      search/
      image-search/
      integrations/
      pricing/
      admin/
      audit/
    common/
    config/
    main.ts
```

## 9. Organização sugerida do frontend

```text
frontend/
  src/
    app/
    components/
    features/
      search/
      catalog/
      comparison/
      stores/
      account/
    services/
    hooks/
    types/
```

## 10. Ambientes

Separar:

- Desenvolvimento.
- Homologação.
- Produção.

Não compartilhar credenciais entre ambientes.

## 11. Observabilidade

Implementar:

- Logs estruturados.
- Identificadores de requisição.
- Métricas de API.
- Monitoramento de filas.
- Monitoramento das integrações.
- Alertas de falhas.

## 12. Estratégia de evolução

Não criar microsserviços antes de existir necessidade técnica comprovada.

Os módulos deverão manter limites claros para permitir extração futura de componentes independentes.
