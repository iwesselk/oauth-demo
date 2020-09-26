defmodule OauthTestWeb.OauthController do
  use OauthTestWeb, :controller
  alias OauthTest.OauthBuddy
  # Google oauth documentation https://developers.google.com/identity/protocols/oauth2/web-server#httprest
  def login_page(conn, _params) do
    conn = put_session(conn, "test_key", "test")
    render(conn, "login.html")
  end

  def loggedin_page(conn, _params) do
    user_key = get_session(conn, "google_code")
    conn = if get_session(conn, "google_tokens") do
      #newstuff = OauthBuddy.refresh_data_from_token(get_session(conn, "google_tokens") |> Map.get("refresh_token"))
      #put_session(conn, "google_tokens", Map.merge(get_session(conn, "google_tokens"), %{}
      #|> Map.put("id_token", Map.get(newstuff, "id_token"))
      #|> Map.put("access_token", Map.get(newstuff, "access_token"))))
      conn
    else
      stuff = OauthBuddy.get_data_from_token(get_session(conn, "google_code"))
      put_session(conn, "google_tokens", stuff)
    end
    userdata = get_session(conn, "google_tokens")
    #showme = inspect(userdata)
    IO.inspect(user_key, label: "User key")
    youridentity = OauthBuddy.read_jwt(Map.get(userdata, "id_token"))
    #showme = inspect(yourname)
    yourname = Map.get(youridentity, "name")
    youremail = Map.get(youridentity, "email")
    render(conn, "loggedin.html", user_key: user_key, yourname: yourname, youremail: youremail)
  end

  def auth(conn, params) do
    conn = put_session(conn, "google_code", Map.get(params, "code"))
    redirect(conn, to: "/loggedin")
  end
end
