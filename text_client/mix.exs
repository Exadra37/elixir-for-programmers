defmodule TextClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :text_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # without declaring hangman as an included application Elixir will start
      #  it for us, because we have it defined as a dependency in deps/0.
      included_applications: [ :hangman ],
      extra_applications:    [ :logger  ],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      hangman: [ path: "../hangman" ],
    ]
  end
end
