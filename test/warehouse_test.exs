defmodule WarehouseTest do
  use ExUnit.Case
  doctest Warehouse

  import ExUnit.CaptureIO

  describe "get_and_parse_stdin/1" do
    test "It gets and parses STDIN" do
      assert capture_io([input: "1\n", capture_prompt: false], fn ->
        IO.write(Warehouse.get_and_parse_stdin())
      end) == "1"
    end
  end

  describe "extract_first_tuple\1" do
    test "It gets the first element of a tuple" do
      assert Warehouse.extract_first_tuple({1, 2}) == 1
    end
  end

  describe "gather_input/2" do
    test "It returns an empty list when parsed_input == 0" do
      assert Warehouse.gather_input(0, fn -> nil end) == []
    end

    test "It output a message when parsed_input == 0" do
      fun = fn -> 
        Warehouse.gather_input(0, fn -> nil end)
      end
      assert capture_io([capture_prompt: false], fun) == "\nYou need to input pairs of numbers\n"
    end

    test "It recurses when parsed_input is a positive number" do
      assert Warehouse.gather_input(1, fn -> 0  end) == [1]
    end
  end

  describe "gather_input/3" do
    test "It returns the current state of inputs when parsed_input is 0" do
      assert Warehouse.gather_input(0, [1, 2, 3, 4], fn -> 0  end) == [1, 2, 3, 4]
    end

    test "It recurses when parsed_input is positive" do
      {:ok, pid} = Agent.start_link(fn -> 3 end)
      fun = fn -> 
        Agent.get_and_update(pid, fn i -> {i, i - 1} end) 
      end
      assert Warehouse.gather_input(4, [], fun) == [1, 2, 3, 4]
    end
  end

  describe "verify_inputs/1" do
    test "It returns the inputs list if it has an even number of elements (meaning numbers can be paired up)" do
      assert Warehouse.verify_inputs([1, 2, 3, 4]) == [1, 2, 3, 4]
    end

    test "It returns an empty list if the inputs list has an odd number of elements" do
      assert Warehouse.verify_inputs([1, 2, 3]) == []
    end

    test "It prints a message if the inputs list has an odd number of elements" do
      assert capture_io(fn -> 
        Warehouse.verify_inputs([1, 2, 3])
      end) == "\nWe don't have an even number of inputs, can't process: [1, 2, 3]\n" 
    end
  end

  describe "tupleize_inputs/1" do
    test "It returns a list of 2-tuples from an even list of numbers" do
      assert Warehouse.tupleize_inputs([4, 3, 2, 1]) == [{1, 2}, {3, 4}]
    end
  end

  describe "answer/2" do
    test "It finds the warehouse ID and returns it as a string" do
      assert Warehouse.answer(1, 1) == "1"
      assert Warehouse.answer(2, 2) == "5"
      assert Warehouse.answer(2, 4) == "12"
      assert Warehouse.answer(4, 1) == "10"
      assert Warehouse.answer(4, 2) == "14"
      assert Warehouse.answer(612, 231) == "354673"
      assert Warehouse.answer(11111, 11111) == "246886421"

      # Fixed bad test case
      assert Warehouse.answer(100000, 100000) == "19999800001"
    end
  end

  describe "calculate_vertical_offset/1" do
    test "It returns 0 when y is less than 0" do
      assert Warehouse.calculate_vertical_offset(-1) == 0
    end

    test "It returns 1 when y is 0" do
      assert Warehouse.calculate_vertical_offset(0) == 1
    end

    test "It recurses when y is greater than or equal to 1" do
      assert Warehouse.calculate_vertical_offset(3) == 7 
    end
  end

  describe "calculate_horizontal_offset/2" do
    test "It returns 0 when x is 1" do
      assert Warehouse.calculate_horizontal_offset(1, 2) == 0
    end

    test "It recurses when x is greater than 1" do
      assert Warehouse.calculate_horizontal_offset(3, 4) == 11
    end
  end

  describe "find_x/2" do
    test "It returns 1 if the ID is the same as the calculated vertical offset" do
      assert Warehouse.find_x(7, 4) == 1
    end
  end

  describe "find_x/3" do
    test "It finds x for a given y and warehouse ID" do
      assert Warehouse.find_x(12, 4) == 2
      # The test below is kinda slow, uncomment to see it assert correctly
      #assert Warehouse.find_x(6436088697, 100000) == 13457
    end
  end
end
