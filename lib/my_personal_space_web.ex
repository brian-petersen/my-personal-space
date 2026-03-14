defmodule MyPersonalSpaceWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use MyPersonalSpaceWeb, :controller
      use MyPersonalSpaceWeb, :html
      use MyPersonalSpaceWeb, :verified_routes

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses, and aliases.
  """

  def static_paths, do: ~w(assets files fonts images robots.txt)

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html],
        layouts: [html: MyPersonalSpaceWeb.LayoutHTML]

      import Plug.Conn

      unquote(verified_routes())
    end
  end

  def html do
    quote do
      use Phoenix.Component

      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      import Phoenix.Template, only: [embed_templates: 1]

      unquote(html_helpers())

      import Phoenix.Component, except: [def: 2, defp: 2]

      import Phoenix.Component, only: [link: 1]
    end
  end

  defp html_helpers do
    quote do
      import Phoenix.HTML
      import Phoenix.HTML.Form
      use PhoenixHTMLHelpers

      import MyPersonalSpaceWeb.Authentication, only: [signed_in?: 1]
      import MyPersonalSpaceWeb.CoreComponents

      alias Phoenix.Flash

      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        router: MyPersonalSpaceWeb.Router,
        endpoint: MyPersonalSpaceWeb.Endpoint,
        statics: MyPersonalSpaceWeb.static_paths()
    end
  end
end
