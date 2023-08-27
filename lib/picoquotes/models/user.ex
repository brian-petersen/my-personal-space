defmodule Picoquotes.Models.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:password_hash, :string)

    field(:password, :string, virtual: true)

    timestamps()
  end

  def build(params) do
    %__MODULE__{}
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:password, min: 8)
    |> validate_format(:username, ~r/^[a-z0-9_-]{3,15}$/i)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  def has_password?(%__MODULE__{password_hash: hash}, password) do
    Bcrypt.verify_pass(password, hash)
  end
end
