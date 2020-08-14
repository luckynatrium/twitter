defmodule TwitterWeb.UsersController do
  use TwitterWeb, :controller
  alias Twitter.Accounts

  require Logger

  alias Twitter.Guardian

  def create(conn, params) do
    with {:ok, user}  <- Accounts.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
    render(conn, "jwt.json", jwt: token)
         else
          err -> err
          Logger.debug("error in user controller/create!!!")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password }) do
    with {:ok, token, _claims} <- Accounts.auth_with_email_password(email, password) do
      render(conn, "jwt.json", jwt: token)
    else
      _ ->
        conn |> put_status(:unauthorized) |> json(%{error: "Login error"})
    end

  end

end
