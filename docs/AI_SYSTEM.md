
# Sistema de Inteligência Artificial — Moto Price Platform

## 1. Objetivo

Implementar pesquisa inteligente de peças e produtos para motocicletas utilizando texto, fotografias e reconhecimento de características visuais.

A inteligência artificial deverá ajudar a localizar produtos no catálogo central, sem substituir a validação técnica de compatibilidade.

## 2. Funcionalidades previstas

- Reconhecimento visual de peças.
- Extração de informações de fotografias.
- Identificação de textos e códigos presentes nas imagens.
- Pesquisa por similaridade visual.
- Pesquisa por características técnicas.
- Reordenação dos produtos candidatos.
- Sugestão de categorias e marcas.
- Identificação de possíveis duplicidades.

## 3. Arquitetura

O módulo de IA deverá ser independente do restante da aplicação.

Criar uma camada de abstração para permitir trocar o provedor de inteligência artificial sem reescrever as regras de negócio.

Componentes:

- ImageUploadService.
- ImageValidationService.
- ImageAnalysisService.
- OCRService.
- EmbeddingService.
- VectorSearchService.
- CandidateRankingService.
- AIProviderAdapter.

## 4. Fluxo de reconhecimento por fotografia

1. Usuário seleciona uma fotografia.
2. Backend recebe o arquivo.
3. Sistema verifica formato, tamanho e conteúdo.
4. Imagem é armazenada em local privado.
5. Uma tarefa é adicionada à fila de processamento.
6. Serviço de IA analisa características visuais.
7. OCR é executado quando houver texto relevante.
8. Embedding visual é gerado.
9. Banco vetorial recupera produtos semelhantes.
10. Sistema aplica filtros de marca, categoria e características.
11. Motor de classificação ordena os candidatos.
12. Usuário recebe os resultados com nível de confiança.

## 5. Pesquisa vetorial

Utilizar pgvector no PostgreSQL.

O modelo de embedding deverá ser escolhido após avaliação técnica.

A dimensão do vetor no banco deverá corresponder exatamente à dimensão produzida pelo modelo selecionado.

Não assumir que todos os provedores produzem vetores de 768 dimensões.

## 6. Classificação de resultados

Considerar:

- Similaridade visual.
- Código identificado por OCR.
- Marca.
- Categoria.
- Nome comercial.
- Características técnicas.
- Modelo e variante.
- Compatibilidade verificada.

A similaridade visual deverá ser tratada como evidência de pesquisa, não como confirmação mecânica.

## 7. Níveis de confiança

Criar faixas de confiança configuráveis após testes com dados rotulados.

Possíveis resultados:

- Correspondência forte.
- Correspondência provável.
- Correspondência incerta.
- Nenhuma correspondência confiável.

Não inventar percentuais de confiança sem calibração experimental.

## 8. Segurança

- Limitar tamanho dos arquivos.
- Validar MIME type e assinatura real do arquivo.
- Rejeitar arquivos inválidos.
- Não executar conteúdo enviado.
- Armazenar imagens privadas.
- Aplicar URLs temporárias quando necessário.
- Remover metadados desnecessários.
- Controlar acesso às imagens.
- Evitar exposição de dados pessoais.

## 9. Avaliação da qualidade

Criar conjunto de teste com fotografias reais e identificação correta dos produtos.

Medir:

- Precision@1.
- Precision@5.
- Recall@5.
- Taxa de falsos positivos.
- Taxa de imagens sem correspondência.
- Tempo médio de processamento.
- Custo por pesquisa.

## 10. Tratamento de erros

Prever:

- Imagem ilegível.
- Formato não suportado.
- Falha do provedor de IA.
- Timeout.
- Falha de armazenamento.
- Embedding indisponível.
- Nenhum produto semelhante.
- Erro de processamento assíncrono.

## 11. Privacidade

Definir finalidade, retenção e descarte das fotografias.

Não reutilizar fotografias dos usuários para treinamento de modelos sem base legal e transparência adequadas.

## 12. Implementação por etapas

### Etapa 1
Upload e validação de imagens.

### Etapa 2
Integração com provedor de análise visual.

### Etapa 3
Geração de embeddings.

### Etapa 4
Pesquisa com pgvector.

### Etapa 5
Reordenação dos resultados.

### Etapa 6
Testes de precisão com peças reais.

### Etapa 7
Monitoramento de custo e desempenho.

## 13. Critério de conclusão

A busca visual só poderá ser considerada implementada quando estiver conectada ao catálogo real, processando imagens reais e apresentando resultados avaliados por testes.
