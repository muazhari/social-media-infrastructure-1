-- Active: 1732281362598@@127.0.0.1@5432@db
-- extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ddl
-- create account table
DROP TABLE IF EXISTS account CASCADE;
CREATE TABLE account (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT,
    email TEXT UNIQUE,
    password TEXT NULL,
    total_post_like NUMERIC DEFAULT 0,
    total_chat_message NUMERIC DEFAULT 0
);

-- create account scope table
DROP TABLE IF EXISTS account_scope CASCADE;
CREATE TABLE account_scope (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    account_id UUID NOT NULL,
    scope TEXT NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account(id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (account_id, scope)
);

-- dml
INSERT INTO account(id, name, email, password, total_post_like, total_chat_message) VALUES
('65c13016-05f5-449b-9472-7afca5de2d03'::uuid, 'name0', 'email0@mail.com', 'password0', 0, 0),
('fb703a0b-9593-4282-bdfc-942131f23182'::uuid, 'name1', 'email1@mail.com', 'password1', 1, 1),
('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid, 'name2', 'email2@mail.com', 'password2', 2, 2);

INSERT INTO account_scope(id, account_id, scope) VALUES
('180158b7-1ca4-4c59-a347-088ab97897a9'::uuid, '65c13016-05f5-449b-9472-7afca5de2d03'::uuid, 'admin'),
('51c2f237-03e5-45ed-9317-e73580b14743'::uuid, 'fb703a0b-9593-4282-bdfc-942131f23182'::uuid, 'user'),
('acf8c50a-4826-4ff3-8f76-ff6c85c0f5e7'::uuid, '2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid, 'guest');