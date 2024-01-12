defmodule MyPersonalSpaceWeb.AuthorsView do
  use MyPersonalSpaceWeb.BaseView

  def get_letters() do
    Enum.map(?A..?Z, &<<&1::utf8>>)
  end
end
