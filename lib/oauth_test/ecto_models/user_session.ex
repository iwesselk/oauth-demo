defmodule OauthTest.UserSession do
  use Ecto.Schema
  #alias OauthTest.User

  schema "user_sessions" do
    #belongs_to :user, User
    field :cookie, Ecto.UUID
    field :table, :map
    timestamps()
  end
end
