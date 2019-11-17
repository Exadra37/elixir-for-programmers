defmodule Gallows.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gallows,
      version: "0.0.1",
      elixir: "1.5.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Gallows.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # ALL DEPENDENCIES LOCKED DOWN TO JUN 2017, THE DATE @PRAGDAVE RECORDED
      #  THIS PART OF THE COURSE.
      {:phoenix, "1.3.0"},
      {:phoenix_pubsub, "1.0.2"},
      {:phoenix_html, "2.9.3"},
      {:phoenix_live_reload, "1.0.8", only: :dev},
      {:gettext, "0.13.1"},
      {:cowboy, "1.1.2"},

      # Needed to add this cowboy dependency in order to lock it to 1.3.5,
      #  otherwise would install 1.8.3, and fail to compile, due to wanting us
      #  to install `{:plug_cowboy, "~> 1.0"}`, that was only released the first
      #  time in 2018, thus before this course.
      #
      # So if got this correct, :cowboy 1.1.2 was installing :plug 1.8.3 that
      #  by its turn was requiring :plug_cowboy 1.0 or newer to be installed
      #  instead of :cowboy itself... WTF!!!
      #
      # It seems that Plug cowboy replaces cowboy as a dependency from 2018
      #  onwards.
      {:plug, "1.3.5"},
      {:hangman, [path: "../hangman"]},
    ]
  end
end
