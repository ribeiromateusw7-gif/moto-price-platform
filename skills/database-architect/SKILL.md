
# Skill: Database Architect

## Função

Projetar, implementar e otimizar o banco de dados da plataforma.

## Tecnologia

PostgreSQL com possibilidade de utilização do pgvector.

## Responsabilidades

- Projetar tabelas.
- Definir relacionamentos.
- Criar migrações.
- Criar índices.
- Otimizar consultas.
- Implementar integridade.
- Definir políticas RLS.
- Planejar backups.
- Avaliar desempenho.

## Entidades principais

- Users.
- Stores.
- Store Members.
- Brands.
- Categories.
- Products.
- Product Identifiers.
- Product Images.
- Image Embeddings.
- Motorcycles.
- Product Compatibility.
- Store Offers.
- Price History.
- Stock History.
- Integrations.
- Integration Runs.

## Regras

1. Evitar duplicidade desnecessária.
2. Preservar histórico comercial.
3. Não permitir preços negativos.
4. Manter integridade referencial.
5. Separar produto canônico de oferta comercial.
6. Não confundir estoque desconhecido com estoque zero.
7. Proteger os dados de cada loja.
8. Versionar todas as alterações estruturais.

## Critério de qualidade

O banco deverá ser íntegro, seguro, documentado e preparado para consultas eficientes.
