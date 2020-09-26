defmodule OauthTest.EctoQueries do
  import Ecto.Query
  alias Ecto.Changeset
  alias OauthTest.Repo
  alias OauthTest.UserSession

  def get_session_by_cookie(cookie) do
    IO.inspect(cookie, label: "session by cookie")
    query = from u in UserSession, where: u.cookie == ^cookie, select: u
    Repo.one!(query)
  end

  def get_session_by_id(id) do
    query = from u in UserSession, where: u.id == ^id, select: u
    Repo.one!(query)
  end

  def delete_session_by_id(id) do
    %UserSession{id: id} |> Repo.delete()
  end

  def update_session(new_session) do
    new_session
    |> Changeset.put_change(:updated_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
    |> Repo.update!()
  end

  def new_session() do
    new = %UserSession{
      cookie: Ecto.UUID.generate(),
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      table: %{}
    }

    Repo.insert!(new)
  end
end
