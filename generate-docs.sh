#!/bin/bash

# Сборка документации
mkdocs build

# Переключаемся в директорию contracts, генерируем документацию и копируем
# cd ../contracts || exit
# doxygen
# mkdir -p ../doctrine/site/contracts
# rsync -r docs/html/* ../doctrine/site/contracts

# Переключаемся в директорию cooptypes, генерируем документацию и копируем
# cd ../components/cooptypes || exit
# pnpm docs
# mkdir -p ../docs/site/cooptypes
# rsync -r docs/* ../docs/site/cooptypes

# Переключаемся в директорию coopback, генерируем документацию и копируем
# cd ../monocoop/components/coopback || exit
# pnpm run docs
# mkdir -p ../../../docs/site/coopback
# rsync -r docs/* ../../../docs/site/coopback

# Возвращаемся в первоначальную директорию и публикуем документацию
# cd ../../../docs || exit
# echo pwd
pnpm run publish

