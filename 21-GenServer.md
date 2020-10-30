# GenServer
```elixir
defmodule ParrotServer do
  use GenServer

  @impl true
  def init(parrot) do
    {:ok, parrot}
  end

  @impl true
  def handle_call({:say, message}, _from, parrot) do
    {:reply, message, parrot}
  end

  @impl true
  def handle_call(:hello, _from, parrot) do
    {:reply, "#{parrot.name} wants a cracker!", parrot}
  end

  @impl true
  def handle_cast({:feed, amount}, parrot) do
    fed = %{parrot | health: parrot.health + amount}
    {:noreply, fed}
  end

  @impl true
  def handle_call(:health, _from, parrot) do
    {:reply, parrot.health, parrot}
  end
end
```
