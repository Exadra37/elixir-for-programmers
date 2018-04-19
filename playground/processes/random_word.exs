defmodule Playground.Processes.RandomWord do

  alias Dictionary.WordList

  # Enum.each(1..100000, fn _ -> spawn(fn -> Process.sleep(5000) end) end)

   #Enum.each(1..10000, fn _ -> spawn(fn number -> number * number end) end)
  def launch(number) do
    words = Dictionary.start()
    randw = fn -> random_word(words) |> greeter() end
    Enum.each(1..number, fn _-> spawn(randw) end)
  end

  defp random_word(words) do
    WordList.random_word(words)
  end

  defp greeter(name) do

    # just for demo purposes, almost never used in production code
    Process.sleep 1000

    IO.puts "-> #{name}"
  end

  def init(number) do
    words = Dictionary.start()
  end

  def z_combinator f do
    combinator = fn(x) -> f.(fn(y) -> x.(x).(y) end)
  end
end

end
