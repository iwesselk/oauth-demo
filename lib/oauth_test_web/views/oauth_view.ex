defmodule OauthTestWeb.OauthView do
  use OauthTestWeb, :view
  alias OauthTest.OauthBuddy

  def get_oauth_url() do
    query_map = %{"client_id" => OauthBuddy.get_client_id(), "redirect_uri" => "http://localhost:4000/login/auth", "response_type" => "code", "scope" => "profile email openid" }

    google_uri = %URI{
      host: "accounts.google.com",
      path: "/o/oauth2/v2/auth",
      query: URI.encode_query(query_map),
      scheme: "https"
    }

    URI.to_string(google_uri)
  end
end
