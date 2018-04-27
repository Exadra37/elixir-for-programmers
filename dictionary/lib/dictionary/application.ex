defmodule Dictionary.Application do

  use Application

  @moduledoc """
  When we start the Dictionary application from mix this function is invoked
  as per definition in Dictionary.Mixfile.application/, thus we don't need to
  start in manually.

  Now if we run `iex -S mix` we will just need to invoke the function
  `Dictionary.WordList.random_word/0` to get our random word back.

  """
  def start(_type, _args) do

    import Supervisor.Spec

    children = [
      worker(Dictionary.WordList, [])
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end

end
