defmodule Solution do
  @spec max_points(points :: [[integer]]) :: integer
  def max_points(points) do
    n = length(points)

    # Helper function to compute greatest common divisor (GCD)
    gcd = fn a, b ->
      # Make sure a and b are non-negative
      a = abs(a)
      b = abs(b)
      # Euclidean algorithm
      Stream.iterate({a, b}, fn {x, y} -> {y, rem(x, y)} end)
      |> Enum.find(fn {_, y} -> y == 0 end)
      |> then(fn {g, _} -> g end)
    end

    # Initialize global max points
    global_max = 0

    # Loop over each point as the base point
    for i <- 0..(n-1), reduce: 0 do
      acc_global ->
        base = Enum.at(points, i)
        {x1, y1} = List.to_tuple(base)

        # Map to count slopes
        slope_count =
          Enum.reduce(0..(n-1), %{}, fn j, map ->
            if i != j do
              {x2, y2} = List.to_tuple(Enum.at(points, j))
              dx = x2 - x1
              dy = y2 - y1

              # Handle vertical line separately
              slope =
                cond do
                  dx == 0 -> {:inf, 0} # Vertical line
                  dy == 0 -> {0, 1}    # Horizontal line
                  true ->
                    g = gcd.(dx, dy)
                    # Reduce fraction and normalize signs (dx positive)
                    dx = div(dx, g)
                    dy = div(dy, g)
                    if dx < 0 do
                      {-dy, -dx}
                    else
                      {dy, dx}
                    end
                end

              Map.update(map, slope, 1, &(&1 + 1))
            else
              map
            end
          end)

        # Max number of points for this base point
        max_for_base =
          slope_count
          |> Map.values()
          |> Enum.max(fn -> 0 end) # default 0 if no other points

        # Include the base point itself (+1)
        acc_global |> max(max_for_base + 1)
    end
  end
end
