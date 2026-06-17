impl Solution {
    pub fn process_str(s: String, k: i64) -> char {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        // len[i] = length of the result string after processing
        // the first i characters of s.
        let mut len = vec![0_i128; n + 1];

        for i in 0..n {
            let cur = len[i];

            len[i + 1] = match chars[i] {
                // Append one character
                'a'..='z' => cur + 1,

                // Remove last character if it exists
                '*' => {
                    if cur > 0 {
                        cur - 1
                    } else {
                        0
                    }
                }

                // Duplicate the whole string
                '#' => cur * 2,

                // Reverse does not change length
                '%' => cur,

                _ => unreachable!(),
            };
        }

        let mut k = k as i128;

        // Out of bounds
        if k < 0 || k >= len[n] {
            return '.';
        }

        // Walk backwards and "undo" operations.
        for i in (0..n).rev() {
            let op = chars[i];

            // Length BEFORE processing this operation
            let before = len[i];

            // Length AFTER processing this operation
            let after = len[i + 1];

            match op {
                'a'..='z' => {
                    // Forward:
                    // previous_string + op
                    //
                    // The newly added character sits at index `before`.
                    if k == before {
                        return op;
                    }

                    // Otherwise the character came from the previous state.
                }

                '*' => {
                    // Forward:
                    // remove last character
                    //
                    // Every surviving index keeps the same position.
                    // Nothing to do.
                }

                '#' => {
                    // Forward:
                    // S -> S + S
                    //
                    // Any index in the second half maps back into
                    // the first copy.
                    if before > 0 {
                        k %= before;
                    }
                }

                '%' => {
                    // Forward:
                    // reverse(S)
                    //
                    // Index mapping:
                    // new_idx = len - 1 - old_idx
                    //
                    // Undo it:
                    k = after - 1 - k;
                }

                _ => unreachable!(),
            }
        }

        '.'
    }
}