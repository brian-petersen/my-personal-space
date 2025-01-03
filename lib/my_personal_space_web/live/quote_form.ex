defmodule MyPersonalSpaceWeb.QuoteFormLive do
  use MyPersonalSpaceWeb, :live_view

  alias MyPersonalSpace.Contexts.AuthorContext
  alias MyPersonalSpace.Contexts.QuoteContext
  alias MyPersonalSpace.Models.Quote

  def mount(params, session, socket) do
    user_id = Map.get(session, "user_id")

    if is_nil(user_id) do
      # TODO add redirect to come back to this page on successful login
      {:ok, redirect(socket, to: ~p"/sessions/new")}
    else
      {quote_id, quote_changeset, submit_action} =
        params
        |> Map.get("permalink")
        |> get_quote_assigns()

      authors = AuthorContext.list_authors_sorted()

      {:ok,
       assign(socket,
         authors: authors,
         error: nil,
         quote: to_form(quote_changeset),
         quote_id: quote_id,
         show_preview: false,
         submit_action: submit_action
       )}
    end
  end

  def render(assigns) do
    ~H"""
    <p :if={@error} class="alert alert-danger alert-dismissable">
      {@error}
      <button type="button" class="close" phx-click="dismiss_error">&times;</button>
    </p>

    <.form for={@quote} phx-change="change" phx-submit={@submit_action}>
      <div class="form-group">
        <label for={@quote[:text].id}>Quote</label>

        <ul class="nav nav-tabs mb-1">
          <li class="nav-item">
            <a
              class={["nav-link", !@show_preview && "active"]}
              href="#"
              phx-click="set_no_show_preview"
            >
              Raw
            </a>
          </li>
          <li class="nav-item">
            <a class={["nav-link", @show_preview && "active"]} href="#" phx-click="set_show_preview">
              Preview
            </a>
          </li>
        </ul>

        <textarea
          :if={!@show_preview}
          type="textarea"
          class="form-control"
          rows="10"
          id={@quote[:text].id}
          name={@quote[:text].name}
        >{@quote[:text].value}</textarea>

        <div :if={@show_preview}>{raw(@quote[:text_rendered].value)}</div>
      </div>

      <%!-- TODO Add way to search authors --%>
      <%!-- TODO Add way add author --%>

      <div class="form-group">
        <label for={@quote[:author_id].id}>Author</label>

        <select class="form-control" id={@quote[:author_id].id} name={@quote[:author_id].name}>
          <option :for={a <- @authors} value={a.id} selected={a.id == @quote[:author_id].value}>
            {a.name}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label for={@quote[:source].id}>Source</label>

        <input
          type="text"
          class="form-control"
          id={@quote[:source].id}
          name={@quote[:source].name}
          value={@quote[:source].value}
        />
      </div>

      <button type="submit" class="btn btn-primary">Submit</button>
    </.form>
    """
  end

  def handle_event("set_show_preview", _params, socket) do
    {:noreply, assign(socket, show_preview: true)}
  end

  def handle_event("set_no_show_preview", _params, socket) do
    {:noreply, assign(socket, show_preview: false)}
  end

  def handle_event("dismiss_error", _params, socket) do
    {:noreply, assign(socket, error: nil)}
  end

  def handle_event("change", %{"quote" => params}, socket) do
    quote =
      params
      |> Quote.build()
      |> to_form(action: :validate)

    {:noreply, assign(socket, quote: quote)}
  end

  def handle_event("create", %{"quote" => params}, socket) do
    case QuoteContext.create_quote(params) do
      {:ok, %{permalink: permalink}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Successfully created quote.")
         |> redirect(to: ~p"/quotes/#{permalink}")}

      {:error, changeset} ->
        {:noreply, assign(socket, error: "Failed to create quote.", quote: to_form(changeset))}
    end
  end

  def handle_event("update", %{"quote" => params}, socket) do
    # TODO figure out why author is reset when submitting an update, quote is blank, and the author resets to the first one
    dbg(params)
    case QuoteContext.update_quote(socket.assigns.quote_id, params) do
      {:ok, %{permalink: permalink}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Successfully edited quote.")
         |> redirect(to: ~p"/quotes/#{permalink}")}

      {:error, changeset} ->
        dbg(changeset)
        {:noreply, assign(socket, error: "Failed to update quote.", quote: to_form(changeset))}
    end
  end

  defp get_quote_assigns(permalink) do
    {id, changeset} =
      if permalink do
        # TODO handle if a quote does not exist
        {:ok, quote} = QuoteContext.get_quote_by_permalink(permalink)
        {quote.id, Quote.build(quote, %{})}
      else
        default_author_id = AuthorContext.default_author_id()
        {nil, Quote.build(%Quote{}, %{author_id: default_author_id})}
      end

    submit_action =
      if permalink do
        "update"
      else
        "create"
      end

    {id, changeset, submit_action}
  end
end
