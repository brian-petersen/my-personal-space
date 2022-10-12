defmodule PicoquotesWeb.BaseView do
  @moduledoc """
  Base view that itegrates with Phoenix as needed
  """

  defmacro __using__([]) do
    quote do
      use Phoenix.View,
        root: "lib/picoquotes_web/templates",
        namespace: PicoquotesWeb

      alias PicoquotesWeb.Router.Helpers, as: Routes

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]
      import Phoenix.Component, only: [sigil_H: 2]

      import PicoquotesWeb.Authentication, only: [signed_in?: 1]
      import PicoquotesWeb.ErrorHelpers

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
    end
  end
end
