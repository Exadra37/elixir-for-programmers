defmodule TextClient.Prompter do

  alias TextClient.State

  def accept_move(text_client_state = %State{}) do
    IO.gets("Your guess: ")
    |> check_input(text_client_state)
  end

  defp check_input({:error, reason}, _text_client_state) do
    IO.puts("Game ended: #{reason}")
    exit :normal
  end

  defp check_input(:eof, _text_client_state) do
    IO.puts("Looks like you gave up...")
    exit :normal
  end

  defp check_input(input, text_client_state = %State{}) do
    input = String.trim(input)

    cond do
      input =~ ~r{\A[a-z]\z} ->
        Map.put(text_client_state, :guess, input)
      true ->
        IO.puts "please enter a single lowercase letter..."
        accept_move(text_client_state)
    end

  end

end
