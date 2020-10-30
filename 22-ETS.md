# Erlang Term Storage (ETS)
```elixir
iex> :ets.new(:my_table, [:named_table])
:my_table
iex> :ets.insert(:my_table, {"self", self()})
true
iex> :ets.lookup(:my_table, "self")
[{"self", #PID<0.41.0>}]
```
