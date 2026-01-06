defmodule Solution do
  @spec eval_rpn(tokens :: [String.t]) :: integer
  def eval_rpn(tokens) do
    # Reduce over tokens, using a list as a stack
    stack =
      Enum.reduce(tokens, [], fn token, stack ->
        case token do
          # Addition
          "+" ->
            [b, a | rest] = stack
            [a + b | rest]

          # Subtraction
          "-" ->
            [b, a | rest] = stack
            [a - b | rest]

          # Multiplication
          "*" ->
            [b, a | rest] = stack
            [a * b | rest]

          # Division (truncate toward zero)
          "/" ->
            [b, a | rest] = stack
            [div(a, b) | rest]

          # Token is a number
          _ ->
            # Convert string to integer and push onto stack
            [String.to_integer(token) | stack]
        end
      end)

    # Final result is the only value left on the stack
    hd(stack)
  end
end
