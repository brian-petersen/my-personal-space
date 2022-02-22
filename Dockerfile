### app builder ###
FROM hexpm/elixir:1.13.3-erlang-24.2.1-alpine-3.15.0 AS builder

RUN apk add --no-cache --update build-base

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV prod

COPY mix.exs mix.lock ./
COPY config config

RUN mix deps.get && \
    mix deps.compile

COPY assets assets
COPY priv priv
COPY lib lib

RUN mix compile && \
    mix assets.deploy && \
    mix release

### final image ###
FROM alpine:3.15.0

WORKDIR /app

RUN apk add --no-cache --update bash libstdc++ ncurses-libs 

COPY entrypoint.sh .
RUN chmod 755 entrypoint.sh

COPY --from=builder /app/_build/prod/rel/picoquotes .

EXPOSE 4000

CMD ["./entrypoint.sh"]
