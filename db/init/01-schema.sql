-- Результаты парсинга профилей форума (структура squashProfiles из примеров app/30.php)

CREATE TABLE IF NOT EXISTS forum_profiles (
    id                  BIGSERIAL PRIMARY KEY,
    source_forum_url    TEXT NOT NULL,
    username            TEXT NOT NULL,
    appearances_count   INTEGER NOT NULL DEFAULT 1,
    profile_posts_total TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (source_forum_url, username)
);

CREATE INDEX IF NOT EXISTS idx_forum_profiles_source
    ON forum_profiles (source_forum_url);

CREATE OR REPLACE FUNCTION set_forum_profiles_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_forum_profiles_updated_at ON forum_profiles;
CREATE TRIGGER trg_forum_profiles_updated_at
    BEFORE UPDATE ON forum_profiles
    FOR EACH ROW
    EXECUTE PROCEDURE set_forum_profiles_updated_at();
