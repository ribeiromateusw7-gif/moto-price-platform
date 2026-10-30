
# ADR 0002 — Catálogo canônico de produtos

- Status: Aceito como recomendação inicial.

## Contexto

Diferentes lojas podem anunciar o mesmo produto usando nomes, descrições e códigos internos diferentes.

## Decisão

Criar um catálogo central de produtos canônicos. Cada oferta comercial de uma loja referencia um produto desse catálogo.

A identificação deve considerar, quando disponíveis:

- Código EAN.
- Código OEM.
- Código do fabricante.
- Marca.
- Modelo e variante.
- Especificações técnicas.
- Compatibilidade com motocicletas.

## Regras

1. Não unir produtos apenas porque seus nomes são parecidos.
2. Preservar o código SKU original de cada loja.
3. Registrar a origem das informações.
4. Permitir revisão manual de correspondências duvidosas.
5. Registrar o histórico das alterações relevantes.
6. Separar compatibilidade confirmada de compatibilidade não verificada.

## Consequências

A comparação de preços poderá agrupar ofertas equivalentes sem misturar peças diferentes.

A busca por fotografia poderá sugerir candidatos, mas não deverá confirmar compatibilidade mecânica somente pela aparência.
