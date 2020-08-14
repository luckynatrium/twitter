defmodule Twitter.Accounts do
  alias Twitter.Accounts.UserQueries
  alias Twitter.Accounts.User
  alias Twitter.Guardian

  def create_user(attrs), do: UserQueries.create(attrs)

  def verify_password(password, %User{} = user) do
    if Argon2.check_pass(user,password) do
      {:ok, user}
    else
      {:error, "Passwords don't match"}
    end
  end

  defp email_password_auth(email, password) do
    with {:ok, user}  <- UserQueries.get_by_email(email) do
      verify_password(password, user)
    end
  end

  def auth_with_email_password(email, password) do
    with {:ok, user} <- email_password_auth(email,password) do
      Guardian.encode_and_sign(user)
    else
      _ -> {:error, :unauthorized}
    end
  end
end
