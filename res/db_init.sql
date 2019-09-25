CREATE TABLE IF NOT EXISTS contacts (
    dht_id text PRIMARY KEY,
    name text NOT NULL,
    photo_url text,
    recent_text text
);