defmodule StudentsCrmV2.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.post": :test,
        coveralls: :test,
        lint_n_test: :test
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      lint_n_test: ["credo --strict", "format --check-formatted", "dialyzer --halt-exit-status", "test"]
    ]
  end

  defp dialyzer do
    [
      flags: [:error_handling, :race_conditions, :underspecs],
      plt_add_deps: :transitive,
      ignore_warnings: ".dialyzer_ignore.exs"
    ]
  end
end
