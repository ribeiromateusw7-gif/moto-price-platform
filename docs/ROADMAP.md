
# Roadmap de Desenvolvimento — Moto Price Platform

## Visão geral

O desenvolvimento será dividido em fases pequenas, testáveis e documentadas.

A prioridade é entregar uma plataforma funcional com dados reais, sem tentar implementar todas as funcionalidades simultaneamente.

## Fase 1 — Fundação

Objetivos:

- Preparar repositório.
- Configurar frontend.
- Configurar backend.
- Configurar TypeScript.
- Configurar lint.
- Configurar testes.
- Configurar CI.
- Preparar ambientes.

Critério de conclusão:

Frontend e backend iniciam corretamente e possuem testes básicos executados.

## Fase 2 — Banco de dados

Objetivos:

- Configurar PostgreSQL.
- Implementar migrações.
- Criar entidades.
- Criar relacionamentos.
- Implementar índices.
- Implementar autorização.
- Configurar backups.

Critério de conclusão:

Banco funcional com testes de integridade e isolamento.

## Fase 3 — Autenticação

Objetivos:

- Cadastro.
- Login.
- Recuperação de senha.
- Perfil do usuário.
- Sessões.
- Controle de permissões.

Critério de conclusão:

Usuários conseguem acessar somente os recursos autorizados.

## Fase 4 — Catálogo

Objetivos:

- Produtos.
- Marcas.
- Categorias.
- Identificadores.
- Imagens.
- Pesquisa textual.
- Controle de duplicidades.

Critério de conclusão:

Catálogo persistente e pesquisável.

## Fase 5 — Lojas e ofertas

Objetivos:

- Cadastro de lojas.
- Aprovação.
- Membros.
- Cadastro de ofertas.
- Preços.
- Estoque.
- Histórico comercial.

Critério de conclusão:

Lojas autorizadas conseguem administrar suas ofertas.

## Fase 6 — Integração comercial

Objetivos:

- Importação CSV.
- Validação de dados.
- Histórico de importações.
- Integration Hub.
- Primeiro conector real.

Critério de conclusão:

Dados comerciais atualizados com origem rastreável.

## Fase 7 — Comparador

Objetivos:

- Comparação de preços.
- Filtros.
- Ordenação.
- Disponibilidade.
- Localização.
- Horário da última atualização.

Critério de conclusão:

Consumidor consegue comparar ofertas reais equivalentes.

## Fase 8 — Pesquisa visual

Objetivos:

- Upload.
- Validação de imagem.
- Processamento assíncrono.
- OCR.
- Embeddings.
- pgvector.
- Classificação.
- Avaliação de precisão.

Critério de conclusão:

Busca por fotografia funcional e avaliada com dados reais.

## Fase 9 — Compatibilidade

Objetivos:

- Cadastro de motocicletas.
- Modelos e anos.
- Compatibilidade.
- Evidências.
- Revisão manual.
- Filtros por motocicleta.

Critério de conclusão:

Compatibilidade apresentada com origem e estado de verificação.

## Fase 10 — Segurança e lançamento

Objetivos:

- Testes de segurança.
- Testes de desempenho.
- Monitoramento.
- Backup.
- Recuperação.
- Documentação.
- Homologação.
- Piloto com lojas de São Luís.

Critério de conclusão:

Plataforma validada para lançamento controlado.

## Fase 11 — Expansão

Objetivos:

- Novas cidades.
- Novas lojas.
- Novos conectores.
- Novas categorias.
- Relatórios.
- Recursos comerciais adicionais.

Critério de conclusão:

Expansão baseada em métricas de uso e qualidade.

## Regra de execução

Não avançar uma fase sem validar os critérios de conclusão da fase anterior.

Todas as entregas devem incluir documentação, testes e registro das limitações.
