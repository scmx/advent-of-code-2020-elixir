%{
  configs: [
    %{
      name: "default",
      strict: true,
      checks: [
        {Credo.Check.Readability.ModuleDoc,
         ignore_names: [
           ~r/(\.Day\d{2}\w+)$/
         ]}
      ]
    }
  ]
}
