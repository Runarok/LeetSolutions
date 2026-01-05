defmodule Solution do
  @spec compute_area(ax1 :: integer, ay1 :: integer, ax2 :: integer, ay2 :: integer,
                     bx1 :: integer, by1 :: integer, bx2 :: integer, by2 :: integer) :: integer
  def compute_area(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2) do

    # Step 1: Area of rectangle A
    area_a = (ax2 - ax1) * (ay2 - ay1)

    # Step 2: Area of rectangle B
    area_b = (bx2 - bx1) * (by2 - by1)

    # Step 3: Calculate overlap boundaries
    overlap_left = max(ax1, bx1)
    overlap_right = min(ax2, bx2)
    overlap_bottom = max(ay1, by1)
    overlap_top = min(ay2, by2)

    # Step 4: Calculate overlap area
    overlap_width = max(0, overlap_right - overlap_left)
    overlap_height = max(0, overlap_top - overlap_bottom)
    overlap_area = overlap_width * overlap_height

    # Step 5: Total area = area A + area B - overlap
    total_area = area_a + area_b - overlap_area

    total_area
  end
end
