defmodule OauthTest.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create_if_not_exists table("users") do
      add :username, :string
      add :haspassword, :boolean
      add :other_data, :map

      timestamps()
    end
  end
end
