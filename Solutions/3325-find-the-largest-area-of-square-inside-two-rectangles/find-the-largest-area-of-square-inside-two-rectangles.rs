impl Solution {
    pub fn largest_square_area(
        bottom_left: Vec<Vec<i32>>,
        top_right: Vec<Vec<i32>>
    ) -> i64 {

        let n = bottom_left.len();

        // This will store the maximum side length of any valid square found
        let mut max_side: i64 = 0;

        // Iterate over all pairs of rectangles
        for i in 0..n {
            for j in i + 1..n {

                // Coordinates of rectangle i
                let x1_i = bottom_left[i][0] as i64;
                let y1_i = bottom_left[i][1] as i64;
                let x2_i = top_right[i][0] as i64;
                let y2_i = top_right[i][1] as i64;

                // Coordinates of rectangle j
                let x1_j = bottom_left[j][0] as i64;
                let y1_j = bottom_left[j][1] as i64;
                let x2_j = top_right[j][0] as i64;
                let y2_j = top_right[j][1] as i64;

                // Compute the overlapping region (intersection)
                // Left edge is the maximum of left edges
                let intersect_left = x1_i.max(x1_j);
                // Right edge is the minimum of right edges
                let intersect_right = x2_i.min(x2_j);

                // Bottom edge is the maximum of bottom edges
                let intersect_bottom = y1_i.max(y1_j);
                // Top edge is the minimum of top edges
                let intersect_top = y2_i.min(y2_j);

                // Compute width and height of the intersection
                let width = intersect_right - intersect_left;
                let height = intersect_top - intersect_bottom;

                // If width and height are both positive, rectangles intersect
                if width > 0 && height > 0 {
                    // Largest square side that can fit in this intersection
                    let side = width.min(height);

                    // Update global maximum
                    if side > max_side {
                        max_side = side;
                    }
                }
            }
        }

        // Return area = side^2
        max_side * max_side
    }
}
