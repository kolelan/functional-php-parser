Functional programming in PHP: Multiprocess parser
======

Исходники вебинара: [http://www.elisdn.ru/blog/98/functional-php-parser](http://www.elisdn.ru/blog/98/functional-php-parser)

## Структура проекта

| Путь | Назначение |
|------|------------|
| `app/` | PHP-парсер, примеры (`01.php` … `31.php`), `parallel/`, кэш HTML |
| `doc/slides/` | Слайды к вебинару (`01.png` … `09.png`) |
| `db/` | PostgreSQL: Dockerfile и SQL-инициализация |
| `docker-compose.yml` | Сервисы `app` и `db` |
| `Makefile` | Команды запуска |

Спаршенные данные хранятся в PostgreSQL (таблица `forum_profiles`). Файловый кэш загрузок по-прежнему в `app/cache/`.

## Быстрый старт

```bash
make build
make up
make install   # если vendor ещё не установлен в volume
make parse     # пример: php 30.php
make db-shell  # psql, \dt
```

Без Make:

```bash
docker compose build
docker compose up -d
docker compose run --rm app composer install
docker compose run --rm app php 30.php
```

Параметры БД по умолчанию: база `parser`, пользователь/пароль `parser`, порт `5432`.
