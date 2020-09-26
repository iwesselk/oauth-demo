defmodule OauthTest.OauthBuddy do
  def get_data_from_token(tok) do
    json = HTTPoison.post!(get_token_url(tok), URI.encode_query(%{
      "client_id" => get_client_id(),
      "client_secret" => get_client_secret(),
      "redirect_uri" => "http://localhost:4000/login/auth",
      "code" => tok,
      "scope" => "",
      "grant_type" => "authorization_code"
    }), %{"Content-Type" => "application/x-www-form-urlencoded"})
    IO.inspect(json, label: "Cloud response")
    data = Jason.decode!(json.body)
    # Map.get(data, "id_token")
    data
  end

  def refresh_data_from_token(tok) do
    json =
      HTTPoison.post!(
        refresh_token_url(tok),
        URI.encode_query(%{
          "client_id" => get_client_id(),
          "client_secret" => get_client_secret(),
          "redirect_url" => "http://localhost:4000/login/auth",
          "code" => tok,
          "scope" => "",
          "grant_type" => "authorization_code"
        })
      )

    data = Jason.decode!(Map.get(json, "body"))
    # Map.get(data, "id_token")
    data
  end

  def get_token_url(_tok) do
    # query_map = %{
    #   "client_id" => get_client_id(),
    #   "client_secret" => get_client_secret(),
    #   "redirect_url" => "http://localhost:4000/login/auth",
    #   "code" => tok,
    #   "scope" => "",
    #   "grant_type" => "authorization_code"
    # }

    google_uri = %URI{
      host: "oauth2.googleapis.com",
      path: "/token",
      scheme: "https"
    }

    URI.to_string(google_uri)
  end

  def refresh_token_url(_tok) do
    # query_map = %{
    #   "client_id" => get_client_id(),
    #   "client_secret" => get_client_secret(),
    #   "redirect_url" => "localhost:4000",
    #   "type" => "refresh_token",
    #   "refresh_token" => tok
    # }

    google_uri = %URI{
      host: "oauth2.googleapis.com",
      path: "/token",
      #query: URI.encode_query(query_map),
      scheme: "https"
    }

    URI.to_string(google_uri)
  end

  def get_client_id() do
    key_secret = Application.fetch_env!(:oauth_test, :google_oauth)
    Map.get(key_secret, "clientID")
  end

  def get_client_secret() do
    key_secret = Application.fetch_env!(:oauth_test, :google_oauth)
    Map.get(key_secret, "secret")
  end

  def read_jwt(jwt) do
    {:ok, claim} = Joken.peek_claims(jwt)
    claim
  end
end
