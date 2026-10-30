
-- Esquema inicial ilustrativo para PostgreSQL.
-- Revisar e testar em ambiente local antes de aplicar.
-- Supõe extensão pgcrypto. pgvector pode ser habilitado separadamente.

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE users (
  id uuid PRIMARY KEY,
  full_name text NOT NULL,
  email text UNIQUE NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE stores (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  legal_name text NOT NULL,
  display_name text NOT NULL,
  cnpj text UNIQUE,
  phone text,
  email text,
  address_line text,
  neighborhood text,
  city text NOT NULL DEFAULT 'São Luís',
  state char(2) NOT NULL DEFAULT 'MA',
  postal_code text,
  latitude double precision,
  longitude double precision,
  status text NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','approved','suspended','rejected')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE store_members (
  store_id uuid NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role text NOT NULL CHECK (role IN ('owner','manager','operator','viewer')),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (store_id, user_id)
);

CREATE TABLE brands (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE
);

CREATE TABLE categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id uuid REFERENCES categories(id),
  name text NOT NULL,
  slug text NOT NULL UNIQUE
);

CREATE TABLE products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES brands(id),
  category_id uuid REFERENCES categories(id),
  canonical_name text NOT NULL,
  description text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  condition text NOT NULL DEFAULT 'new'
    CHECK (condition IN ('new','used','refurbished')),
  status text NOT NULL DEFAULT 'active'
    CHECK (status IN ('active','inactive','under_review')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE product_identifiers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  identifier_type text NOT NULL
    CHECK (identifier_type IN ('ean','manufacturer_part_number','oem','other')),
  identifier_value text NOT NULL,
  source text,
  verified boolean NOT NULL DEFAULT false,
  UNIQUE (identifier_type, identifier_value)
);

CREATE INDEX products_category_idx ON products(category_id);
CREATE INDEX products_brand_idx ON products(brand_id);

CREATE TABLE product_images (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  storage_path text NOT NULL,
  image_role text NOT NULL DEFAULT 'catalog',
  source text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Dimensão de embedding deve corresponder ao modelo escolhido.
-- 768 é apenas um exemplo; ajustar antes de criar índices e inserir vetores.
CREATE TABLE image_embeddings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_image_id uuid NOT NULL REFERENCES product_images(id) ON DELETE CASCADE,
  model_name text NOT NULL,
  embedding vector(768) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (product_image_id, model_name)
);

CREATE TABLE motorcycles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  manufacturer text NOT NULL,
  model text NOT NULL,
  version text,
  model_year integer,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE product_compatibility (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  motorcycle_id uuid NOT NULL REFERENCES motorcycles(id) ON DELETE CASCADE,
  fitment_status text NOT NULL DEFAULT 'unverified'
    CHECK (fitment_status IN ('verified','unverified','rejected')),
  source_name text,
  source_reference text,
  reviewed_by uuid REFERENCES users(id),
  reviewed_at timestamptz,
  notes text,
  UNIQUE (product_id, motorcycle_id)
);

CREATE TABLE integrations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id uuid NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  provider_name text NOT NULL,
  provider_version text,
  connection_type text NOT NULL
    CHECK (connection_type IN ('rest_api','webhook','csv','xml','other')),
  status text NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','testing','active','paused','error','revoked')),
  secret_reference text, -- referência a secret manager; nunca o segredo em si
  configuration jsonb NOT NULL DEFAULT '{}'::jsonb,
  last_success_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE store_offers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  store_id uuid NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  product_id uuid NOT NULL REFERENCES products(id),
  source_integration_id uuid REFERENCES integrations(id),
  source_item_id text,
  store_sku text,
  original_title text,
  price numeric(12,2) NOT NULL CHECK (price >= 0),
  currency char(3) NOT NULL DEFAULT 'BRL',
  availability text NOT NULL DEFAULT 'unknown'
    CHECK (availability IN ('in_stock','out_of_stock','on_order','unknown')),
  quantity integer CHECK (quantity IS NULL OR quantity >= 0),
  source_updated_at timestamptz,
  observed_at timestamptz NOT NULL DEFAULT now(),
  is_active boolean NOT NULL DEFAULT true,
  UNIQUE (store_id, source_item_id)
);

CREATE INDEX store_offers_product_price_idx
  ON store_offers(product_id, price) WHERE is_active = true;
CREATE INDEX store_offers_store_idx ON store_offers(store_id);

CREATE TABLE price_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_id uuid NOT NULL REFERENCES store_offers(id) ON DELETE CASCADE,
  price numeric(12,2) NOT NULL CHECK (price >= 0),
  currency char(3) NOT NULL DEFAULT 'BRL',
  observed_at timestamptz NOT NULL DEFAULT now(),
  source text
);

CREATE INDEX price_history_offer_time_idx
  ON price_history(offer_id, observed_at DESC);

CREATE TABLE stock_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_id uuid NOT NULL REFERENCES store_offers(id) ON DELETE CASCADE,
  availability text NOT NULL,
  quantity integer,
  observed_at timestamptz NOT NULL DEFAULT now(),
  source text
);

CREATE TABLE integration_runs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  integration_id uuid NOT NULL REFERENCES integrations(id) ON DELETE CASCADE,
  status text NOT NULL CHECK (status IN ('queued','running','succeeded','partial','failed')),
  started_at timestamptz,
  finished_at timestamptz,
  items_received integer NOT NULL DEFAULT 0,
  items_created integer NOT NULL DEFAULT 0,
  items_updated integer NOT NULL DEFAULT 0,
  error_summary text,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb
);

CREATE TABLE search_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id) ON DELETE SET NULL,
  query_text text,
  selected_motorcycle_id uuid REFERENCES motorcycles(id),
  search_type text NOT NULL CHECK (search_type IN ('text','image')),
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Nota: habilitar RLS e criar políticas específicas por tabela antes de expor
-- o banco ao frontend. A autorização também deve ser validada no backend.
