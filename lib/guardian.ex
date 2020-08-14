defmodule Twitter.Guardian do
  use Guardian, otp_app: :twitter
  alias Twitter.Accounts.User

  def subject_for_token(%User{} = user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{} = claims) do
    id = claims["sub"]
    resource = Twitter.Accounts.UserQueries.get_by_id(id)
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

end
