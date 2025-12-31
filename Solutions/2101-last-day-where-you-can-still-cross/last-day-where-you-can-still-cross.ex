defmodule Solution do
  @spec latest_day_to_cross(row :: integer, col :: integer, cells :: [[integer]]) :: integer
  def latest_day_to_cross(row, col, cells) do
    total = row * col

    # --------------------------------------------------
    # CREATE UNION-FIND STRUCTURES (SAFE INITIALIZATION)
    # --------------------------------------------------

    # parent[i] = i initially
    parent =
      Enum.reduce(0..(total + 1), :array.new(total + 2), fn i, arr ->
        :array.set(i, i, arr)
      end)

    # rank[i] = 0 initially
    rank = :array.new(total + 2, default: 0)

    # Virtual nodes
    top = total
    bottom = total + 1

    # --------------------------------------------------
    # GRID: false = water, true = land
    # --------------------------------------------------
    grid =
      :array.new(row,
        default: :array.new(col, default: false)
      )

    # --------------------------------------------------
    # PROCESS DAYS IN REVERSE
    # --------------------------------------------------
    cells
    |> Enum.with_index(1)
    |> Enum.reverse()
    |> Enum.reduce_while({parent, rank, grid}, fn {[r, c], day},
                                                  {parent, rank, grid} ->

      # Convert to 0-based
      r = r - 1
      c = c - 1

      # Mark cell as land
      row_arr = :array.get(r, grid)
      row_arr = :array.set(c, true, row_arr)
      grid = :array.set(r, row_arr, grid)

      idx = r * col + c

      # Connect to top virtual node
      {parent, rank} =
        if r == 0 do
          union(idx, top, parent, rank)
        else
          {parent, rank}
        end

      # Connect to bottom virtual node
      {parent, rank} =
        if r == row - 1 do
          union(idx, bottom, parent, rank)
        else
          {parent, rank}
        end

      # Check 4 neighbors
      directions = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]

      {parent, rank} =
        Enum.reduce(directions, {parent, rank}, fn {dr, dc}, acc ->
          nr = r + dr
          nc = c + dc

          if nr >= 0 and nr < row and nc >= 0 and nc < col do
            if :array.get(nc, :array.get(nr, grid)) do
              neighbor_idx = nr * col + nc
              union(idx, neighbor_idx, elem(acc, 0), elem(acc, 1))
            else
              acc
            end
          else
            acc
          end
        end)

      # If top and bottom are connected → answer found
      if find(top, parent) == find(bottom, parent) do
        {:halt, day - 1}
      else
        {:cont, {parent, rank, grid}}
      end
    end)
  end

  # --------------------------------------------------
  # FIND WITH PATH COMPRESSION
  # --------------------------------------------------
  defp find(x, parent) do
    px = :array.get(x, parent)

    if px != x do
      root = find(px, parent)
      :array.set(x, root, parent)
      root
    else
      x
    end
  end

  # --------------------------------------------------
  # UNION BY RANK
  # --------------------------------------------------
  defp union(x, y, parent, rank) do
    px = find(x, parent)
    py = find(y, parent)

    cond do
      px == py ->
        {parent, rank}

      :array.get(px, rank) < :array.get(py, rank) ->
        {:array.set(px, py, parent), rank}

      :array.get(px, rank) > :array.get(py, rank) ->
        {:array.set(py, px, parent), rank}

      true ->
        parent = :array.set(py, px, parent)
        rank = :array.set(px, :array.get(px, rank) + 1, rank)
        {parent, rank}
    end
  end
end
