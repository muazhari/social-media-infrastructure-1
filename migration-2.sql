-- extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ddl
-- Create the account table
DROP TABLE IF EXISTS account CASCADE;
CREATE TABLE account (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT,
    email TEXT UNIQUE,
    password TEXT NULL
    total_post_like NUMERIC DEFAULT 0,
    total_chat_message NUMERIC DEFAULT 0,
);
