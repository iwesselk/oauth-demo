defmodule OauthTest.Repo do
  use Ecto.Repo,
    otp_app: :oauth_test,
    adapter: Ecto.Adapters.Postgres
end
