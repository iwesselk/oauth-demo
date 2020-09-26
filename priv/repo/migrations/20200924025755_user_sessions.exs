defmodule OauthTest.Repo.Migrations.UserSessions do
  use Ecto.Migration

  def change do
    create_if_not_exists table("user_sessions") do
      add :user, references("users")
      add :cookie, :uuid
      add :table,    :map

      timestamps()
    end
  end
end
