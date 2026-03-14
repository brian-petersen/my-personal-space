defmodule MyPersonalSpaceWeb.ErrorHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("error_html/*")

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
