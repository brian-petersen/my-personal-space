#!/bin/sh

mix ecto.create
mix ecto.migrate
mix run --no-halt
