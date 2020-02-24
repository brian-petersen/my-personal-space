### builder ###
FROM hexpm/elixir:1.10.1-erlang-22.2.7-alpine-3.11.3 as builder

ENV MIX_ENV prod

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs .
COPY mix.lock .

RUN mix deps.get && \
    mix deps.compile

COPY config config
COPY lib lib
COPY priv priv
RUN mix compile

COPY rel rel
RUN mix release

### app ###
FROM alpine:3.11.3 as app

WORKDIR /app

RUN apk update && \
    apk add ncurses-libs

COPY --from=builder /app/_build/prod/rel/picoquotes .

EXPOSE 4000

CMD ["/app/bin/picoquotes", "start"]
