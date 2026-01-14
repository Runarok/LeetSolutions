// Segment Tree data structure for counting covered lengths along x-axis
struct SegmentTree {
    count: Vec<i32>,    // number of overlapping intervals in a segment
    covered: Vec<i32>,  // total length of the segment that is covered
    xs: Vec<i32>,       // discrete x-coordinates (segment boundaries)
    n: usize,           // number of segments (xs.len() - 1)
}

impl SegmentTree {
    // Constructor: takes a vector of discrete x-coordinates
    fn new(xs: Vec<i32>) -> Self {
        let n = xs.len() - 1;  // number of segments between xs
        SegmentTree {
            count: vec![0; 4 * n],    // 4*n is safe for segment tree size
            covered: vec![0; 4 * n],  // initialize covered lengths to 0
            xs,
            n,
        }
    }
    
    // Internal recursive modify function: updates segments for [qleft, qright)
    fn modify(&mut self, qleft: i32, qright: i32, qval: i32, 
              left: usize, right: usize, pos: usize) {
        // If the current segment is completely outside query range, return
        if self.xs[right + 1] <= qleft || self.xs[left] >= qright {
            return;
        }

        // If the current segment is completely inside query range, update count
        if qleft <= self.xs[left] && self.xs[right + 1] <= qright {
            self.count[pos] += qval;
        } else {
            // Otherwise, partially covered: recurse into left and right children
            let mid = (left + right) / 2;
            self.modify(qleft, qright, qval, left, mid, pos * 2 + 1);
            self.modify(qleft, qright, qval, mid + 1, right, pos * 2 + 2);
        }
        
        // Update covered length based on count
        if self.count[pos] > 0 {
            // Segment fully covered
            self.covered[pos] = self.xs[right + 1] - self.xs[left];
        } else {
            if left == right {
                // Leaf segment, not covered
                self.covered[pos] = 0;
            } else {
                // Internal node: sum up covered lengths from children
                self.covered[pos] = self.covered[pos * 2 + 1] + self.covered[pos * 2 + 2];
            }
        }
    }
    
    // Public API to update the segment tree
    fn update(&mut self, qleft: i32, qright: i32, qval: i32) {
        self.modify(qleft, qright, qval, 0, self.n - 1, 0);
    }
    
    // Query total covered length
    fn query(&self) -> i32 {
        self.covered[0]  // root contains total covered length
    }
}

impl Solution {
    pub fn separate_squares(squares: Vec<Vec<i32>>) -> f64 {
        // Step 1: Generate events for sweep line
        // Each event = (y-coordinate, type (+1 for start, -1 for end), x-left, x-right)
        let mut events: Vec<(i32, i32, i32, i32)> = Vec::new();
        let mut xs_set = std::collections::BTreeSet::new();  // for discretizing x coordinates
        
        for sq in squares {
            let (x, y, l) = (sq[0], sq[1], sq[2]);   // bottom-left corner and side length
            let xr = x + l;                           // right boundary
            events.push((y, 1, x, xr));              // square start
            events.push((y + l, -1, x, xr));         // square end
            xs_set.insert(x);
            xs_set.insert(xr);
        }
        
        // Step 2: Sort events by y-coordinate (sweep line from bottom to top)
        events.sort_by_key(|&(y, _, _, _)| y);

        // Step 3: Discretize x coordinates
        let xs: Vec<i32> = xs_set.into_iter().collect();

        // Step 4: Initialize segment tree for x-axis
        let mut seg_tree = SegmentTree::new(xs);
        
        // Step 5: Sweep line to compute prefix sums of area and widths
        let mut psum: Vec<i64> = Vec::new();    // area accumulated up to this event
        let mut widths: Vec<i32> = Vec::new();  // width of covered segments at this y
        let mut total_area = 0;                 // total area of all squares
        let mut prev = events[0].0;             // previous y-coordinate
        
        for &(y, delta, xl, xr) in &events {
            let length = seg_tree.query();  // width of covered segments along x
            total_area += length as i64 * (y - prev) as i64;  // area contribution
            seg_tree.update(xl, xr, delta);  // update covered segments
            psum.push(total_area);           // store prefix sum of area
            widths.push(seg_tree.query());   // store width at this y
            prev = y;
        }
        
        // Step 6: Find y-coordinate that separates area in half (target)
        let target = ((total_area as f64 + 1.0) / 2.0).floor() as i64;  // half of total area, rounded up

        // Binary search for the event where accumulated area >= target
        let i = {
            let mut left = 0;
            let mut right = psum.len().saturating_sub(1);
            let mut result = 0;
            
            while left <= right {
                let mid = left + (right - left) / 2;
                if psum[mid] < target {
                    result = mid;      
                    left = mid + 1;
                } else {
                    right = right.saturating_sub(1);
                }
            }
            result
        };
        
        // Step 7: Compute exact fractional height for halving area
        let area = psum[i];          // accumulated area up to this event
        let width = widths[i];       // width at this y
        let height = events[i].0;    // y-coordinate of event

        // Calculate fractional height to get exactly half of total area
        height as f64 + (total_area as f64 - area as f64 * 2.0) / (width as f64 * 2.0)
    }
}
