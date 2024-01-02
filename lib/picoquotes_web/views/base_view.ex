defmodule PicoquotesWeb.BaseView do
  @moduledoc """
  Base view that itegrates with Phoenix as needed
  """

  defmacro __using__([]) do
    quote do
      use Phoenix.View,
        root: "lib/picoquotes_web/templates",
        namespace: PicoquotesWeb

      alias Phoenix.Flash
      alias PicoquotesWeb.Router.Helpers, as: Routes

      import PicoquotesWeb.Authentication, only: [signed_in?: 1]
      import PicoquotesWeb.ErrorHelpers

      # Use all HTML functionality (forms, tags, etc)
      import Phoenix.HTML
      import Phoenix.HTML.Form
      use PhoenixHTMLHelpers
    end
  end
end
