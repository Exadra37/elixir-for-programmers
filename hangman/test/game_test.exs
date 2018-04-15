defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do

    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initialising
    assert length(game.letters) > 0

    # your turn task
    assert game.letters |> to_string()  =~ ~r{^[a-z]+\z}

  end

  test "test the guess cannot contain more than 1 letter" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "xy")
    assert game.game_state === :guess_to_long
  end

  test "test the guess only contains a valid letter" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "1")
    assert game.game_state === :not_a_valid_letter

    { game, _tally } = Game.make_move(game, 1)
    assert game.game_state === :not_a_valid_letter
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "state isn't changed for :won game" do

    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end

  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is reconized" do
    game = Game.new_game("wibble")

    { game, _tally } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do

    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"b", :already_used},
      {"l", :good_guess},
      {"e", :won},
    ]

    game = Game.new_game("wibble")

    fun = fn ({ guess, state }, game) ->
            { game, _tally} = Game.make_move(game, guess)
            assert game.game_state == state
            game
          end

    Enum.reduce(moves, game, fun)

  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do

    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 1},
    ]

    game = Game.new_game("x")

    fun = fn ({ guess, state, turns_left }, game) ->
            { game, _tally} = Game.make_move(game, guess)
            assert game.game_state == state
            assert game.turns_left == turns_left
            game
          end

    Enum.reduce(moves, game, fun)

  end

end
