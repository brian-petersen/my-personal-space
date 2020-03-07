### app builder ###
FROM hexpm/elixir:1.10.1-erlang-22.2.7-alpine-3.11.3 AS app_builder

ENV MIX_ENV prod

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY app/mix.exs .
COPY app/mix.lock .

RUN mix deps.get && \
    mix deps.compile

COPY app/config config
COPY app/lib lib
COPY app/priv priv

RUN mix compile

RUN mix release

### web builder ###
FROM node:12.16.1-alpine AS web_builder

WORKDIR /app

COPY web/package.json .
COPY web/yarn.lock .

RUN yarn

COPY web/src src

RUN yarn build

### final image ###
FROM alpine:3.11.3

WORKDIR /app

RUN apk update && \
    apk add ncurses-libs

COPY entrypoint.sh .
COPY --from=app_builder /app/_build/prod/rel/picoquotes .
COPY --from=web_builder /app/dist static

EXPOSE 4000

CMD ["./entrypoint.sh"]
