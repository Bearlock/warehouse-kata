# Warehouse

A kata for solving a 'warehouse' problem

```
| 11
| 7 12
| 4 8 13
| 2 5 9 14
| 1 3 6 10 15
```

Given a particular coordinate pair, return the 'ID' at that location.

For example, (3, 3) should return '13', with a few other caveats.

# Running the script

1. `git clone` this repo
2. `cd` into `warehouse/`
3. `mix run warehouse.exs` in order to kick off the script
4. Enter as many return-separated numbers as you'd like to process (except 0)
5. Enter 0 when you'd like the script to stop reading numbers and begin calculation

# Running tests

1. `git clone` this repo
2. `cd` into `warehouse/`
3. `mix test` to run the test suite

The test suite should have all the test cases (as well as the fixed test case) outlined in the prompt. There is also a commented out test for `find_x/3` because it isn't as fast as I would like it to be; feel free to uncomment it to validate it.

# Project Structure

The bulk of the logic is in `lib/warehouse.ex`. `warehouse.exs` is a handy dandy script that uses cade in the Warehouse module to do it's stuff, and all the tests are in `tests/warehouse_tests.ex`
