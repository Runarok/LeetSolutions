defmodule Solution do
  @spec largest_triangle_area(points :: [[integer]]) :: float
  def largest_triangle_area(points) do
    n = length(points)

    # Helper function to calculate the area of a triangle given three points
    area = fn [x1, y1], [x2, y2], [x3, y3] ->
      abs(x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2)) / 2.0
    end

    # Initialize max_area to 0
    max_area = 0.0

    # Loop over all combinations of three different points
    max_area =
      for i <- 0..(n-3), j <- (i+1)..(n-2), k <- (j+1)..(n-1), reduce: 0.0 do
        acc ->
          a = Enum.at(points, i)
          b = Enum.at(points, j)
          c = Enum.at(points, k)

          # Calculate area of triangle formed by points a, b, c
          current_area = area.(a, b, c)

          # Keep the maximum
          max(acc, current_area)
      end

    max_area
  end
end
