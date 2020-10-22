defmodule Account do
  @enforce_keys [:username, :email]
  defstruct [:username, :email, :description, account_type: :basic ]
end
