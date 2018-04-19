defmodule Playground.Processes.RandomWord do

  alias Dictionary.WordList

  def start() do
    Dictionary.start()
  end

  # Enum.each(1..100000, fn _ -> spawn(fn -> Process.sleep(5000) end) end)

  def launch(number, words) do
    function = fn words -> random_word(words) |> greeter() end
    #Enum.each(1..2, function)
    Enum.each(1..10, fn  -> spawn(function) end)

  end

  defp random_word(words) do
    WordList.random_word(words)
  end

  defp greeter(name) do

    # just for demo purposes, almost never used in production code
    Process.sleep 1000

    IO.puts "RANDOM WORD: #{name}"
  end

end
