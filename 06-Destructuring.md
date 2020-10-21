# Pattern Matching
```elixir
iex> {a, b} = {4, 5}
{4, 5}
iex> a
4
iex> b
5
iex> {:ok, value} = {:error, "Invalid username"}
** (MatchError) no match of right hand side value: {:error, "Invalid username"}
```
