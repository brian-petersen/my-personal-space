ARG elixir_version=1.15.0
ARG erlang_version=26.0.1
ARG alpine_version=3.18.2

### app builder ###
FROM hexpm/elixir:$elixir_version-erlang-$erlang_version-alpine-$alpine_version AS builder

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
FROM alpine:$alpine_version

ENV ECTO_IPV6 true
ENV ERL_AFLAGS "-proto_dist inet6_tcp"

WORKDIR /app

RUN apk add --no-cache --update bash libstdc++ ncurses-libs

COPY --from=builder /app/_build/prod/rel/picoquotes .

EXPOSE 4000

CMD ["bin/picoquotes", "start"]
