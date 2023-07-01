defmodule PicoquotesWeb.AuthorsView do
  use PicoquotesWeb.BaseView

  def get_letters() do
    Enum.map(?A..?Z, &<<&1::utf8>>)
  end
end
