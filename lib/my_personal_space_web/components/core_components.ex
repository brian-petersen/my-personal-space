defmodule MyPersonalSpaceWeb.CoreComponents do
  @moduledoc """
  Core UI components with Bootstrap styling.
  """
  use Phoenix.Component

  alias Phoenix.HTML.FormData

  @doc """
  Renders a form with Bootstrap styling.

  ## Examples

      <.bootstrap_form for={@form} action="/quotes">
        <.input field={@form[:text]} type="textarea" label="Quote" />
        <.button type="submit">Submit</.button>
      </.bootstrap_form>
  """
  attr :for, :any, required: true, doc: "the data structure for the form"
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"
  attr :id, :string, default: nil
  attr :action, :string, default: nil
  attr :method, :string, default: "post"
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(phx-change phx-submit csrf_token)
  slot :inner_block, required: true

  def bootstrap_form(%{for: for_data} = assigns) do
    form =
      case for_data do
        %Phoenix.HTML.Form{} = form -> form
        changeset_or_map -> FormData.to_form(changeset_or_map, [])
      end

    assigns =
      assigns
      |> assign(:form, form)
      |> assign(:form_attrs, form_attributes(form, assigns))

    assigns = assign(assigns, :csrf_token, Phoenix.Controller.get_csrf_token())
    assigns = assign(assigns, :method, normalize_method(assigns.method))

    ~H"""
    <form {@form_attrs}>
      <input type="hidden" name="_csrf_token" value={@csrf_token} />
      <input type="hidden" name="_method" value={@method} />
      {render_slot(@inner_block, @form)}
    </form>
    """
  end

  defp normalize_method("patch"), do: "PATCH"
  defp normalize_method("put"), do: "PUT"
  defp normalize_method(method), do: method

  defp form_attributes(form, assigns) do
    attrs = [
      id: assigns[:id] || form.id,
      method: "post",
      class: assigns[:class]
    ]

    attrs =
      if assigns[:action] do
        Keyword.put(attrs, :action, assigns.action)
      else
        attrs
      end

    attrs =
      if assigns[:as] do
        Keyword.put(attrs, :as, assigns.as)
      else
        attrs
      end

    attrs =
      if assigns.rest[:"phx-change"] do
        Keyword.put(attrs, :"phx-change", assigns.rest[:"phx-change"])
      else
        attrs
      end

    attrs =
      if assigns.rest[:"phx-submit"] do
        Keyword.put(attrs, :"phx-submit", assigns.rest[:"phx-submit"])
      else
        attrs
      end

    attrs |> Enum.reject(fn {_k, v} -> is_nil(v) end)
  end

  @doc """
  Renders a form input with Bootstrap styling.

  ## Examples

      <.input field={@form[:email]} type="email" label="Email" />
      <.input field={@form[:body]} type="textarea" label="Body" rows="10" />
      <.input field={@form[:author_id]} type="select" options={@authors} label="Author" />
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :type, :string, default: "text"
  attr :label, :string, default: nil
  attr :placeholder, :string, default: nil
  attr :class, :string, default: "form-control"
  attr :options, :list, default: []
  attr :rest, :global

  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div class="form-group">
      <%= if @label do %>
        <label for={@field.id}>{@label}</label>
      <% end %>
      <textarea
        id={@field.id}
        name={@field.name}
        class={@class}
        placeholder={@placeholder}
        {@rest}
      ><%= @field.value %></textarea>
    </div>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div class="form-group">
      <%= if @label do %>
        <label for={@field.id}>{@label}</label>
      <% end %>
      <select
        id={@field.id}
        name={@field.name}
        class={@class}
        {@rest}
      >
        {Phoenix.HTML.Form.options_for_select(@options, @field.value)}
      </select>
    </div>
    """
  end

  def input(%{type: type} = assigns) when type in ["password", "email"] do
    ~H"""
    <div class="form-group">
      <%= if @label do %>
        <label for={@field.id}>{@label}</label>
      <% end %>
      <input
        type={@type}
        id={@field.id}
        name={@field.name}
        value={@field.value}
        class={@class}
        placeholder={@placeholder}
        {@rest}
      />
    </div>
    """
  end

  def input(assigns) do
    ~H"""
    <div class="form-group">
      <%= if @label do %>
        <label for={@field.id}>{@label}</label>
      <% end %>
      <input
        type={@type}
        id={@field.id}
        name={@field.name}
        value={@field.value}
        class={@class}
        placeholder={@placeholder}
        {@rest}
      />
    </div>
    """
  end

  @doc """
  Renders a button with Bootstrap styling.

  ## Examples

      <.button type="submit" class="btn btn-primary">Save</.button>
  """
  attr :type, :string, default: "button"
  attr :class, :string, default: "btn btn-primary"
  attr :rest, :global
  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button type={@type} class={@class} {@rest}>
      {render_slot(@inner_block)}
    </button>
    """
  end
end
