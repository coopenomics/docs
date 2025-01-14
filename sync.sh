#!/bin/bash

# Базовый путь из .env
source .env

# mkdir -p "$DOCS_PATH/graphql"
rsync -r "$BASE_PATH/monocoop/components/docs/graphql" "$START_PATH"
rsync -r "$BASE_PATH/monocoop/components/docs/sdk" "$START_PATH"