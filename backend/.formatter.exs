[
  import_deps: [:phoenix],
  inputs: [
    "mix.exs",
    "apps/*/mix.exs",
    "{config,lib,priv,test}/**/*.{ex,exs}",
    "apps/*/{config,lib,priv,test}/**/*.{ex,exs}"
  ],
  line_length: 120
]
