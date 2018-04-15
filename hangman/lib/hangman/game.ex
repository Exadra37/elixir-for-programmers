defmodule Hangman.Game do

  # TODO:
  #   → Can i improve this?
  @valid_letters ?a..?z |> Enum.to_list() |> to_string() |> String.split("", trim: true)

  defstruct(
    turns_left: 7,
    game_state: :initialising,
    letters:    [],
    used:       MapSet.new(),
  )

  ### PUBLIC API ####

  def new_game() do
    new_game(Dictionary.random_word)
  end

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  def make_move(game, guess) do
    game
    |> accept_move(guess)
    |> game_tally()
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters:    game.letters |> revelal_guessed(game.used)
    }
  end


  ### PRIVATE ####

  defp accept_move(game, guess) when byte_size(guess) > 1 do
    Map.put(game, :game_state, :guess_to_long)
  end

  defp accept_move(game, guess) when not guess in @valid_letters do
    Map.put(game, :game_state, :not_a_valid_letter)
  end

  defp accept_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    game
  end

  defp accept_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _not_guessed_yet) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> maybe_won()

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{ turns_left: 1 }, _not_good_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(game = %{ turns_left: turns_left }, _not_good_guess) do
    %{ game |
      game_state: :bad_guess,
      turns_left: turns_left - 1
    }
  end

  defp maybe_won(true) do
    :won
  end

  defp maybe_won(_) do
    :good_guess
  end

  defp revelal_guessed(letters, used) do

    function = fn letter ->
                 letter
                 |> reveal_letter(MapSet.member?(used, letter))
               end

    letters
    |> Enum.map(function)
  end

  defp reveal_letter(letter, _in_word = true) do
    letter
  end

  defp reveal_letter(_letter, _not_in_word) do
    "_"
  end

  defp game_tally(game) do
    { game, tally(game) }
  end
end
