defmodule Warehouse do
  @moduledoc """
  Documentation for Warehouse.
  """

  require Integer

  def get_and_parse_stdin() do
    "" 
    |> IO.gets()
    |> Integer.parse()
    |> extract_first_tuple()
  end

  def extract_first_tuple({first, _}), do: first

  def gather_input(parsed_input, fetch_data) do
    case parsed_input do
      0 ->
        IO.puts("\nYou need to input pairs of numbers")
        []
      _ ->
        fetch_data.()
        |> gather_input([parsed_input], fetch_data)
    end
  end

  def gather_input(parsed_input, inputs, fetch_data) do
    case parsed_input do
      0 ->
        inputs
      _ ->
        fetch_data.()
        |> gather_input([parsed_input | inputs], fetch_data)
    end
  end

  def verify_inputs(inputs) do
    if Integer.is_even(length(inputs))  do
      inputs
    else
      IO.inspect(inputs, label: "\nWe don't have an even number of inputs, can't process")
      []
    end
  end

  def tupleize_inputs(inputs) do
    inputs
    |> Enum.reverse()
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
  end 

  def answer(x, y) do
    row_first = calculate_vertical_offset(y - 1)
    row_first + calculate_horizontal_offset(x, y)
    |> Integer.to_string()
  end

  def calculate_vertical_offset(y) when y < 0, do: 0
  def calculate_vertical_offset(0), do: 1
  def calculate_vertical_offset(y) do
    y + calculate_vertical_offset(y - 1)
  end

  def calculate_horizontal_offset(1, _), do: 0
  def calculate_horizontal_offset(x, y) do
    y + x - 1 + calculate_horizontal_offset(x - 1, y)
  end

  def find_x(id, y) do
    if calculate_vertical_offset(y - 1) == id do
      1
    else
      find_x(id, y, 2) 
    end
  end

  def find_x(id, y, step) do
    if calculate_vertical_offset(y - 1) + calculate_horizontal_offset(step, y) == id do
      step
    else
      find_x(id, y, step + 1)
    end
  end
end
