-- extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ddl
-- Create the post table
DROP TABLE IF EXISTS post CASCADE;
CREATE TABLE post (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    account_id UUID NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL
);

-- Create the post like table
DROP TABLE IF EXISTS post_like CASCADE;
CREATE TABLE post_like (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID NOT NULL,
    account_id UUID NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE
);

-- Create the chat room table
DROP TABLE IF EXISTS chat_room CASCADE;
CREATE TABLE chat_room (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL
);

-- Create the chat room member table
DROP TABLE IF EXISTS chat_room_member CASCADE;
CREATE TABLE chat_room_member (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chat_room_id UUID NOT NULL,
    account_id UUID NOT NULL,
    FOREIGN KEY (chat_room_id) REFERENCES chat_room(id) ON DELETE CASCADE
);

-- Create the chat message table
DROP TABLE IF EXISTS chat_message CASCADE;
CREATE TABLE chat_message (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chat_room_id UUID NOT NULL,
    account_id UUID NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (chat_room_id) REFERENCES chat_room(id) ON DELETE CASCADE
);