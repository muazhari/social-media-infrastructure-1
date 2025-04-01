-- Active: 1743308173981@@127.0.0.1@5433@db
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
    password TEXT NULL,
    total_post_like NUMERIC DEFAULT 0,
    total_chat_message NUMERIC DEFAULT 0
);

-- dml
INSERT INTO account(id, name, email, password, total_post_like, total_chat_message) VALUES
('65c13016-05f5-449b-9472-7afca5de2d03'::uuid, 'name0', 'email0@mail.com', 'password0', 0, 0),
('fb703a0b-9593-4282-bdfc-942131f23182'::uuid, 'name1', 'email1@mail.com', 'password1', 1, 1),
('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid, 'name2', 'email2@mail.com', 'password2', 2, 2);