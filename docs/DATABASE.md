
# Estrutura do Banco de Dados — Moto Price Platform

## 1. Tecnologia

Banco de dados principal: PostgreSQL.

Extensões previstas:

- pgcrypto: geração de identificadores e funções criptográficas.
- pgvector: armazenamento e pesquisa de embeddings.

## 2. Entidades principais

### Usuários
Tabela: `users`

Armazena:

- Identificador.
- Nome completo.
- E-mail.
- Data de criação.

### Lojas
Tabela: `stores`

Armazena:

- Razão social.
- Nome comercial.
- CNPJ.
- Telefone.
- E-mail.
- Endereço.
- Bairro.
- Cidade.
- Estado.
- Coordenadas geográficas.
- Situação cadastral.

### Membros das lojas
Tabela: `store_members`

Relaciona usuários às lojas e define suas permissões.

Funções previstas:

- Proprietário.
- Gerente.
- Operador.
- Visualizador.

### Marcas
Tabela: `brands`

Mantém as marcas dos produtos.

### Categorias
Tabela: `categories`

Organiza os produtos em categorias e subcategorias.

### Produtos
Tabela: `products`

Representa o produto canônico, independentemente da loja que o comercializa.

### Identificadores
Tabela: `product_identifiers`

Armazena códigos EAN, OEM e códigos dos fabricantes.

### Imagens
Tabela: `product_images`

Armazena referências aos arquivos de imagens dos produtos.

### Embeddings
Tabela: `image_embeddings`

Armazena representações vetoriais para pesquisa visual.

### Motocicletas
Tabela: `motorcycles`

Armazena fabricante, modelo, versão e ano.

### Compatibilidade
Tabela: `product_compatibility`

Relaciona produtos às motocicletas compatíveis, mantendo o estado da verificação.

### Ofertas
Tabela: `store_offers`

Relaciona uma loja a um produto do catálogo e registra:

- Preço.
- Moeda.
- SKU da loja.
- Disponibilidade.
- Quantidade conhecida.
- Origem dos dados.
- Data da última observação.

### Histórico de preços
Tabela: `price_history`

Mantém o histórico dos preços observados.

### Histórico de estoque
Tabela: `stock_history`

Mantém o histórico de disponibilidade e quantidade.

### Integrações
Tabela: `integrations`

Armazena as configurações e o estado das integrações comerciais.

### Execuções de integração
Tabela: `integration_runs`

Registra execuções, quantidades processadas e falhas.

### Sessões de pesquisa
Tabela: `search_sessions`

Registra pesquisas realizadas pelos consumidores, respeitando as regras de privacidade.

## 3. Relacionamentos principais

- Uma loja possui vários membros.
- Um usuário pode participar de várias lojas.
- Uma marca pode possuir vários produtos.
- Uma categoria pode possuir vários produtos.
- Um produto pode possuir vários identificadores.
- Um produto pode possuir várias imagens.
- Um produto pode ter compatibilidade com várias motocicletas.
- Uma loja pode possuir várias ofertas.
- Um produto pode ser anunciado por várias lojas.
- Uma oferta pode possuir histórico de preços e estoque.
- Uma loja pode possuir várias integrações.

## 4. Regras de integridade

1. Não permitir preços negativos.
2. Não permitir quantidades negativas.
3. Preservar o SKU original da loja.
4. Evitar duplicidade de identificadores verificados.
5. Preservar o histórico de preços.
6. Não apagar o histórico ao atualizar uma oferta.
7. Diferenciar estoque zero de estoque desconhecido.
8. Registrar a origem e o horário das informações.

## 5. Segurança

Aplicar controle de acesso por loja.

O usuário de uma loja não poderá consultar ou modificar dados privados de outra loja.

As políticas RLS devem ser implementadas e testadas antes de liberar acesso direto ao banco.

As credenciais administrativas devem permanecer exclusivamente no servidor.

## 6. Índices e desempenho

Criar índices para:

- Identificadores dos produtos.
- Categorias.
- Marcas.
- Produtos por oferta.
- Ofertas por loja.
- Histórico por oferta e data.
- Pesquisa vetorial por imagem.

Avaliar índices adicionais com base nas consultas reais.

## 7. Migrações

Toda alteração de estrutura deverá ser versionada por migrações.

Não realizar alterações manuais diretamente em produção.

## 8. Evolução futura

Possíveis entidades adicionais:

- Carrinhos.
- Favoritos.
- Avaliações.
- Cupons.
- Pedidos.
- Notificações.
- Assinaturas comerciais.
- Histórico de cliques.
- Relatórios de desempenho.
