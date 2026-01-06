defmodule Solution do
  @spec final_prices(prices :: [integer]) :: [integer]
  def final_prices(prices) do
    # Convert prices to a tuple for easy index updates
    n = length(prices)
    result = Enum.to_list(prices)

    # Use Enum.with_index to track indices
    # Stack will store indices of items waiting for discount
    {result, _stack} =
      Enum.reduce(Enum.with_index(prices), {result, []}, fn {price, i}, {res, stack} ->
        # Check if current price can be used as a discount for items on stack
        {res, stack} =
          Enum.reduce_while(stack, {res, []}, fn idx, {acc_res, acc_stack} ->
            if price <= Enum.at(prices, idx) do
              # Apply discount for the index
              new_res = List.update_at(acc_res, idx, fn old -> old - price end)
              {:cont, {new_res, acc_stack}}
            else
              # Keep in stack if no discount yet
              {:cont, {acc_res, [idx | acc_stack]}}
            end
          end)

        # Push current index onto stack
        {res, [i | stack]}
      end)

    result
  end
end
