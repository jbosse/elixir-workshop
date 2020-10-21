# Structs
```elixir
defmodule Account do
  @enforce_keys [:username, :email]
  defstruct [:username, :email, account_type: :basic, :description ]
end

iex> %Account{username: "jbosse", email: "jimmy@funkyboss.com"}
%Account{
  account_type: :basic,
  description: nil,
  email: "jimmy@funkyboss.com",
  username: "jbosse"
}
```
