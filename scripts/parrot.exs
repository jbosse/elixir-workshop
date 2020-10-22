defmodule Parrot do
  def start_link(parrot) do
    Task.start_link(fn -> live(parrot) end)
  end

  defp live(parrot) do
    receive do
      {:say, msg} ->
        IO.puts(msg)
        live(parrot)
      :hello ->
        IO.puts("#{parrot.name} wants a cracker!")
        live(parrot)
      {:feed, amount} ->
        fed = %{parrot | health: parrot.health + amount}
        IO.puts("#{fed.name}'s health is now #{fed.health}")
        live(fed)
    end
  end
end
