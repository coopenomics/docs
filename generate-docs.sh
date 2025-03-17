#!/bin/bash

# Базовый путь из .env
source .env
MONO_PATH=$BASE_PATH

# Сборка документации
mkdocs build

# # Переключаемся в директорию contracts, генерируем документацию и копируем
# cd "$BASE_PATH/contracts" || exit
#doxygen

# mkdir -p "$DOCS_PATH/graphql"
#rsync -r "$BASE_PATH/monocoop/components/docs/graphql" "$DOCS_PATH"

# # Переключаемся в директорию cooptypes, генерируем документацию и копируем
# cd "$BASE_PATH/monocoop/components/cooptypes" || exit
# pwd
# pnpm run docs
# mkdir -p "$BASE_PATH/doctrine/site/cooptypes"
# rsync -r docs/* "$BASE_PATH/doctrine/site/cooptypes"

# # Переключаемся в директорию coopback, генерируем документацию и копируем
# cd "$BASE_PATH/monocoop/components/coopback" || exit
# pnpm run docs
# mkdir -p "$BASE_PATH/doctrine/site/coopback"
# rsync -r docs/* "$BASE_PATH/doctrine/site/coopback"

# Возвращаемся в первоначальную директорию и публикуем документацию
# cd "$BASE_PATH/doctrine" || exit
pnpm run publish
