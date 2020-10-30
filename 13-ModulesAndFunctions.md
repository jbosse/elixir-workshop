# Modules and Functions
```elixir
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end

iex> c "math.exs"
[Math]
iex> Math.sum(1, 2)
3
iex> Math.do_sum(1, 2)
** (UndefinedFunctionError) function Math.do_sum/2 is undefined or private
```
