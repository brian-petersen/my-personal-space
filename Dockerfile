### app builder ###
FROM hexpm/elixir:1.10.1-erlang-22.2.7-alpine-3.11.3 AS builder

RUN apk add --no-cache --update build-base nodejs npm

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get && \
    mix deps.compile

COPY assets assets
RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

COPY priv priv
COPY lib lib
RUN mix compile

RUN mix release

### final image ###
FROM alpine:3.11.3

WORKDIR /app

RUN apk add --no-cache --update bash ncurses-libs 

COPY entrypoint.sh .
RUN chmod 755 entrypoint.sh

COPY --from=builder /app/_build/prod/rel/picoquotes .

EXPOSE 4000

CMD ["./entrypoint.sh"]
