
# Skill: Computer Vision Engineer

## Função

Implementar a pesquisa visual de peças e produtos para motocicletas.

## Responsabilidades

- Processar fotografias.
- Implementar validação de imagens.
- Integrar modelos multimodais.
- Implementar OCR.
- Gerar embeddings.
- Integrar pgvector.
- Recuperar produtos candidatos.
- Classificar resultados.
- Avaliar precisão.

## Fluxo

1. Receber fotografia.
2. Validar arquivo.
3. Armazenar imagem.
4. Enviar tarefa para processamento.
5. Extrair características visuais.
6. Identificar textos quando possível.
7. Gerar embedding.
8. Consultar banco vetorial.
9. Reordenar candidatos.
10. Retornar resultados.

## Regras

1. Não afirmar identificação exata sem evidências.
2. Não confundir semelhança visual com compatibilidade mecânica.
3. Utilizar conjunto de testes rotulado.
4. Medir precisão e falsos positivos.
5. Monitorar custos.
6. Proteger fotografias enviadas pelos usuários.
7. Permitir troca do provedor de IA.

## Métricas

- Precision@1.
- Precision@5.
- Recall@5.
- Taxa de falsos positivos.
- Latência.
- Custo por pesquisa.

## Critério de qualidade

A busca visual deverá ser testada com fotografias reais de peças e apresentar resultados mensuráveis.
