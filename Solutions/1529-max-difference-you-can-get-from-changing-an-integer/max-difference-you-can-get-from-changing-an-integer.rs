impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        // Closure to transform all occurrences of digit `x` in `num` into digit `y`.
        // Returns the resulting number as a String.
        let change = |x: i32, y: i32| -> String {
            num.to_string() // convert the original number to string
                .chars()    // iterate over each digit character
                .map(|digit| {
                    // convert digit char to integer and compare to x
                    if digit.to_digit(10).unwrap() as i32 == x {
                        // replace digit with y, converting y to a character
                        (y as u8 + b'0') as char
                    } else {
                        // keep the digit unchanged
                        digit
                    }
                })
                .collect() // collect the transformed chars back into a String
        };

        // Initialize minimum and maximum with the original number
        let mut min_num = num;
        let mut max_num = num;

        // Try all possible digit replacements:
        // for each digit x from 0 to 9,
        // try replacing all occurrences of x with y (also from 0 to 9)
        for x in 0..10 {
            for y in 0..10 {
                let res = change(x, y);

                // Skip results with leading zero (not valid numbers)
                if res.chars().nth(0).unwrap() != '0' {
                    // Parse the transformed string back to integer
                    let res_i: i32 = res.parse().unwrap();

                    // Update minimum and maximum accordingly
                    min_num = min_num.min(res_i);
                    max_num = max_num.max(res_i);
                }
            }
        }

        // Return the difference between maximum and minimum possible numbers
        max_num - min_num
    }
}
