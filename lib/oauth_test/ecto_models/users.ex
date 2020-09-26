defmodule OauthTest.User do
  use Ecto.Schema

  schema "users" do
    field :username, :string
    field :haspassword, :boolean
    field :other_data, :map
    timestamps()
  end
end
