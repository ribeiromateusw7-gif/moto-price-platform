
# MASTER PROMPT — Plataforma inteligente de busca e comparação de produtos para motocicletas

Atue como uma equipe sênior de arquitetura, frontend, backend, banco de dados, IA visual, integração ERP, segurança, QA e DevOps.

## Missão

Construir do zero uma plataforma web que começa em São Luís/MA e permite pesquisar produtos para motocicletas por texto ou fotografia, localizar produtos equivalentes no catálogo e comparar ofertas reais de lojas participantes.

## Regra central

Não entregue apenas protótipo visual. Implemente backend, banco persistente, autenticação, APIs, integrações autorizadas, processamento real de imagens e testes. Não simule recursos em produção.

## Antes de programar

1. Inspecione o repositório e o ambiente.
2. Leia todos os documentos em `docs/`.
3. Leia as decisões em `adr/`.
4. Apresente plano de execução e riscos.
5. Identifique credenciais, serviços e autorizações necessários.
6. Não invente APIs de ERP, chaves, preços ou dados comerciais.

## Arquitetura

Use inicialmente monólito modular:

- Next.js + TypeScript para web.
- NestJS + TypeScript para API.
- PostgreSQL para persistência.
- Supabase Auth/Storage, se adequado.
- pgvector para embeddings.
- Redis + BullMQ para tarefas assíncronas.
- Adaptadores para provedores de IA e conectores ERP.

Justifique qualquer alteração tecnológica.

## Domínios

- Identidade e permissões.
- Lojas e membros.
- Catálogo canônico.
- Marcas e categorias.
- Motocicletas e compatibilidade.
- Ofertas, preços e estoque.
- Pesquisa textual e visual.
- IA e embeddings.
- Integrações comerciais.
- Geolocalização.
- Administração e auditoria.

## Catálogo e comparação

Um produto canônico pode ter ofertas de várias lojas. Compare somente produtos equivalentes considerando código, marca, variante, especificações e compatibilidade.

Registre origem e horário da informação. Não trate estoque desconhecido como disponível.

## IA visual

Implemente upload seguro, análise visual, OCR quando útil, embeddings e recuperação por similaridade.

Use adaptadores de provedor. Crie conjunto de avaliação com fotografias reais rotuladas.

Meça:

- Precision@K.
- Recall@K.
- Falsos positivos.
- Latência.
- Custo.

Semelhança visual não comprova compatibilidade mecânica. Quando houver dúvida, apresente candidatos ou peça informações adicionais.

## Integrações

Crie Integration Hub com adaptadores isolados.

Primeiro identifique o ERP, versão, documentação, autorização e ambiente de teste da loja parceira.

Implemente somente conectores documentados.

Use:

- Webhooks assinados.
- Idempotência.
- Retry.
- Backoff.
- Logs.
- Monitoramento.

Ofereça CSV como fallback.

## Segurança

Implemente autorização por loja, RLS, proteção de segredos, validação de arquivos, rate limit, auditoria, backups e requisitos LGPD.

Nunca exponha credenciais no frontend.

## Método

Trabalhe em pequenas entregas:

1. Fundação e CI.
2. Banco e autenticação.
3. Catálogo.
4. Lojas e ofertas.
5. Importação e primeiro conector real.
6. Comparador.
7. Busca visual.
8. Geolocalização.
9. Segurança, testes e lançamento piloto.

Em cada etapa:

- Explique o objetivo.
- Liste arquivos criados/modificados.
- Implemente.
- Execute testes.
- Informe resultados reais.
- Atualize documentação.
- Registre limitações e próximos passos.

## Critério de conclusão

Não declare concluído algo que não foi executado e testado.

Separe claramente:

- Implementado.
- Parcialmente implementado.
- Bloqueado por credenciais/terceiros.
- Planejado.

Comece lendo o repositório e produzindo o plano técnico da Fase 1. Não gere todo o sistema de uma só vez.
