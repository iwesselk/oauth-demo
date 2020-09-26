defmodule Plug.Session.Ecto do
  @behaviour Plug.Session.Store
  alias OauthTest.EctoQueries
  alias Ecto.Changeset

  def delete(_conn, sid, _opts) do
    EctoQueries.delete_session_by_id(sid)
  end
  def get(_conn, cookie, _opts) do
    IO.inspect(cookie, label: "Cookie is")
    my_session = EctoQueries.get_session_by_cookie(cookie)
    IO.inspect(my_session.table, label: "Cookie table")
    {my_session.id, my_session.table}
  end
  def init(params) do
    IO.inspect(params, label: "Ecto session started with the params:")
  end

  def put(_conn, nil, a, _opts) do
    IO.inspect(a, label: "Table put new is")
    session = EctoQueries.new_session()
    IO.inspect(session, label: "Fucking session")
    session |> Changeset.change(%{table: a}) |> EctoQueries.update_session() |> Map.get(:cookie)
  end
  def put(_conn, sid, a, _opts) do
    IO.inspect(a, label: "Table put old is")
    session = EctoQueries.get_session_by_id(sid)
    IO.inspect(session, label: "gotten Session")
    session |> Changeset.change(%{table: a}) |> EctoQueries.update_session() |> Map.get(:cookie)
  end
end
