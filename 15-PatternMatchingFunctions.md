# Pattern Matching Function Arguments
```elixir
defmodule Jimmy do
  def is_ok({:ok, value}) do
    IO.puts("Hello #{value}")
  end
  def is_ok({status, value}) do
    IO.puts("status: #{status}")
    IO.puts("value: #{value}")
  end
end
```
