"Reading data...\n\n"
|> IO.puts()

Warehouse.get_and_parse_stdin()
|> Warehouse.gather_input(&Warehouse.get_and_parse_stdin/0)
|> Warehouse.verify_inputs()
|> Warehouse.tupleize_inputs()
|> IO.inspect(label: "Tuples")
|> Enum.map(fn {x, y} -> Warehouse.answer(x, y) end)
|> IO.inspect(label: "Warehouse IDs")
