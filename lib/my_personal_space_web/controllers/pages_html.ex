defmodule MyPersonalSpaceWeb.PagesHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("pages_html/*")
end
