FROM hexpm/elixir:1.10.1-erlang-22.2.7-alpine-3.11.3

RUN apk add --no-cache --update build-base inotify-tools git nodejs npm

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix archive.install --force hex phx_new 1.4.16
