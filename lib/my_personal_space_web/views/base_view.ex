defmodule MyPersonalSpaceWeb.BaseView do
  @moduledoc """
  Base view that itegrates with Phoenix as needed
  """

  defmacro __using__([]) do
    quote do
      use Phoenix.View,
        root: "lib/my_personal_space_web/templates",
        namespace: MyPersonalSpaceWeb

      use Phoenix.VerifiedRoutes,
        router: MyPersonalSpaceWeb.Router,
        endpoint: MyPersonalSpaceWeb.Endpoint

      alias Phoenix.Flash
      alias MyPersonalSpaceWeb.Router.Helpers, as: Routes

      import MyPersonalSpaceWeb.Authentication, only: [signed_in?: 1]
      import MyPersonalSpaceWeb.ErrorHelpers

      # Use all HTML functionality (forms, tags, etc)
      import Phoenix.HTML
      import Phoenix.HTML.Form
      use PhoenixHTMLHelpers
    end
  end
end
