ARG elixir_version=1.20.2
ARG erlang_version=28.5.0.3
ARG alpine_version=3.24.1

### app builder ###
FROM docker.io/hexpm/elixir:$elixir_version-erlang-$erlang_version-alpine-$alpine_version AS builder

RUN apk add --no-cache --update build-base

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config

RUN MIX_OS_DEPS_COMPILE_PARTITION_COUNT=$(($(nproc) / 2 || 1)) \
    mix deps.get && \
    mix deps.compile

COPY assets assets
COPY priv priv
COPY lib lib

RUN mix compile && \
    mix assets.deploy && \
    mix release

### final image ###
FROM alpine:$alpine_version

ENV ECTO_IPV6=true
ENV ERL_AFLAGS="-proto_dist inet6_tcp"

WORKDIR /app

RUN apk add --no-cache --update bash libstdc++ ncurses-libs

COPY --from=builder /app/_build/prod/rel/my_personal_space .

EXPOSE 4000

CMD ["bin/my_personal_space", "start"]
