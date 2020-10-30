# Pattern Matching Function Arguments
```elixir
defmodule Math do
  def is_allowed(1), do: false
  def is_allowed(2), do: false
  def is_allowed(3), do: false
  def is_allowed(_), do: true
end
```
