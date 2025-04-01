-- Active: 1743308173981@@127.0.0.1@5433@db
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
    name TEXT NOT NULL,
    description TEXT NOT NULL
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

-- dml
INSERT INTO post(account_id, title, content)
SELECT account.id, 'title0', 'content0'
FROM ( 
    VALUES 
    ('65c13016-05f5-449b-9472-7afca5de2d03'::uuid), 
    ('fb703a0b-9593-4282-bdfc-942131f23182'::uuid),
    ('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid)
) AS account(id);

select * from post;


INSERT INTO post_like(post_id, account_id) 
SELECT post.id, account.id
FROM post
CROSS JOIN ( 
    VALUES 
    ('65c13016-05f5-449b-9472-7afca5de2d03'::uuid), 
    ('fb703a0b-9593-4282-bdfc-942131f23182'::uuid),
    ('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid)
) AS account(id);

INSERT INTO chat_room(name, description) VALUES
('name0', 'description0'),
('name1', 'description1'),
('name2', 'description2');

INSERT INTO chat_room_member(chat_room_id, account_id)
SELECT chat_room.id, account.id
FROM chat_room
CROSS JOIN ( 
    VALUES 
    ('65c13016-05f5-449b-9472-7afca5de2d03'::uuid), 
    ('fb703a0b-9593-4282-bdfc-942131f23182'::uuid),
    ('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid)
) AS account(id);

INSERT INTO chat_message(chat_room_id, account_id, content)
SELECT chat_room.id, account.id, 'content0'
FROM chat_room
CROSS JOIN ( 
    VALUES 
    ('65c13016-05f5-449b-9472-7afca5de2d03'::uuid), 
    ('fb703a0b-9593-4282-bdfc-942131f23182'::uuid),
    ('2c61386d-0f37-48bb-a247-9cb5927d8974'::uuid)
) AS account(id);



