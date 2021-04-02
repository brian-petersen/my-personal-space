defmodule Picoquotes.Notifications.Client do
  @callback create_link_push(title :: binary(), message :: binary(), url :: binary()) ::
              {:ok, term()} | {:error, term()}

  @callback create_note_push(title :: binary(), message :: binary()) ::
              {:ok, term()} | {:error, term()}
end
