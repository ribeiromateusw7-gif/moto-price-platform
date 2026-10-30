
# ADR 0001 — Monólito modular como arquitetura inicial

- Status: Aceito como recomendação inicial.
- Contexto: produto em estágio inicial, equipe e volume ainda não validados.
- Decisão: backend NestJS organizado em módulos de domínio, com workers assíncronos.
- Consequências positivas: menor custo operacional, desenvolvimento e deploy mais simples.
- Consequências negativas: exige disciplina para preservar limites internos.
- Revisitar: quando houver gargalos medidos, escalabilidade independente ou necessidade organizacional.
