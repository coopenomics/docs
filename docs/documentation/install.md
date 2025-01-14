# Полный установка

Для старта MONO склонируйте репозиторий:

```
git clone https://github.com/coopenomics/mono
```

Выполните установку пакетов:

```
cd mono
pnpm install
```

Скопируйте конфигурационный файл бэкенда:

```
cp components/coopback/.env-example components/coopback/.env
```

Скопируйте конфигурационный файл фронтенда:

```
cp components/terminal/src/config/Env.ts components/terminal/src/config/Env.ts
```

Скопируйте конфигурационный файл парсера:
```
cp components/cooparser/.env-example components/cooparser/.env
```

Настройте переменные окружения во всех скопированных конфигурационных файлах. 

!!! note ""
  При подключении к тестовой среде использовать следующие конечные точки блокчейна: https://api-testnet.coopenomics.world, при работе с производственной сетью: https://api.coopenomics.world


После конфигурации произведите сборку MONO из корня:

```
pnpm run build
```

И выполните запуск MONO:
```
pnpm run dev
```


После запуска приложение бэкенда будет доступно на localhost:2998, приложение фронтенда на localhost:3005. Парсер блокчейна начнёт обработку блоков и откроет свой API для извлечения исторических данных на localhost:4000. 



