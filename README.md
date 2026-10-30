
# Plataforma Inteligente de Busca e Comparação de Produtos para Motocicletas

**Cidade inicial:** São Luís — MA, Brasil  
**Nome comercial:** a definir  
**Versão do documento:** 1.0  
**Status:** blueprint técnico inicial — não é uma aplicação pronta para produção.

## Objetivo

Construir uma plataforma que permita ao consumidor pesquisar produtos para motocicletas por texto ou fotografia, identificar possíveis correspondências no catálogo e comparar ofertas reais de lojas participantes.

O projeto começa em São Luís/MA, mas deve permitir expansão para outras cidades.

## Princípios fundamentais

1. Um catálogo central representa cada produto canônico.
2. Cada loja possui sua própria oferta, preço e disponibilidade.
3. A comparação só agrupa produtos quando houver evidência suficiente de equivalência.
4. Semelhança visual não comprova compatibilidade mecânica.
5. Preços e estoques sempre exibem origem e horário da última atualização.
6. Integrações com sistemas comerciais só serão consideradas reais quando houver documentação, credenciais e testes.
7. Dados de demonstração devem ser claramente identificados como dados de teste.

## Conteúdo do repositório

- `docs/`: visão do produto, arquitetura, banco, APIs, IA, integrações, segurança, roadmap e testes.
- `database/`: SQL inicial para PostgreSQL.
- `api/`: contrato OpenAPI inicial.
- `skills/`: instruções para especialidades/agentes de desenvolvimento.
- `prompts/`: prompt mestre para a IA programadora.
- `adr/`: decisões arquiteturais registradas.

## Arquitetura recomendada

- Frontend: Next.js + TypeScript.
- Backend: NestJS + TypeScript.
- Dados: PostgreSQL.
- Autenticação e armazenamento: Supabase Auth/Storage, com autorização validada no backend e RLS no banco.
- Busca visual: embeddings de imagem + pgvector.
- Processamento assíncrono: Redis + BullMQ.
- IA multimodal: provedor selecionado por interface adaptadora; OpenAI ou Gemini podem ser avaliados.
- Hospedagem: escolher após validar requisitos, custos, região e processamento assíncrono.

A arquitetura inicial recomendada é um **monólito modular**, não microsserviços. Os módulos devem ter limites claros para permitir extração futura quando houver necessidade comprovada.

## Como começar

1. Leia `docs/PROJECT.md` e `docs/ARCHITECTURE.md`.
2. Revise as decisões em `adr/`.
3. Revise o SQL em `database/001_initial_schema.sql` antes de executar.
4. Configure ambientes separados para desenvolvimento, homologação e produção.
5. Não coloque segredos em arquivos versionados.
6. Implemente primeiro catálogo, lojas, ofertas e integração piloto.
7. A busca por fotografia entra na primeira versão pública, mas deve usar catálogo real e testes de precisão.
8. Não anuncie integração automática com uma loja até confirmar que o sistema dela oferece um mecanismo autorizado de integração.

## Aviso de escopo

Este repositório reúne o planejamento técnico e um esqueleto inicial de dados e contratos. Ele não contém credenciais, integrações de ERP prontas, modelos de IA treinados, nem uma aplicação implantada. Esses componentes dependem de implementação, serviços escolhidos e autorização dos parceiros comerciais.
