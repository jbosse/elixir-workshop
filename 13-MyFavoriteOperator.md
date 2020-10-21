# My Favorite Operator
```elixir
defmodule Favorite do
  def process(result) do
   result
   |> strip_status()
   |> String.reverse()
  end

  defp strip_status({:ok, value}), do: value
  defp strip_status(_), do: "unknown"
end
```
