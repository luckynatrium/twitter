defmodule TwitterWeb.UsersController do
  use TwitterWeb, :controller
  alias Twitter.Accounts
  alias Twitter.Tweets

  require Logger

  alias Twitter.Guardian

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "jwt.json", jwt: token)
    else
      _ -> Logger.debug("error in user controller/create!!!")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.auth_with_email_password(email, password) do
      {:ok, token, _claims} -> render(conn, "jwt.json", jwt: token)
      _ -> conn
           |> put_status(:unauthorized)
           |> json(%{error: "Login error"})
    end
  end

  def liked_tweets(conn, %{"users_id" => user_id}) do
    conn
    |> put_view(TwitterWeb.TweetsView)
    |> render( "index.json",  %{tweets: Tweets.liked_tweets(user_id)})
  end

  def follow(conn, attrs) do
    Accounts.create_follower(attrs)
    render(conn, "ok.json", %{})
  end

  def folowee_tweets(conn, %{"user_id" => user_id}) do
    conn
    |> put_view(TwitterWeb.TweetsView)
    |> render("index.json", %{tweets: Accounts.followees_tweets(user_id)})
  end
end
