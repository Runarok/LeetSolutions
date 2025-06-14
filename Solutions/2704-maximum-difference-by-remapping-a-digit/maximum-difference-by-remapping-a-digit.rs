impl Solution {
    pub fn min_max_difference(num: i32) -> i32 {
        // Step 1: Convert the integer num to a string for easy digit manipulation
        let num_str = num.to_string();
        
        // Step 2: Prepare to find the maximum value possible by remapping one digit
        // Bob can replace all occurrences of one digit with another digit (0-9)
        // We try all digits 0-9 for both source digit and target digit, but only remap digits present in num
        
        // Step 3: Define a closure that takes a string and returns max number after remapping one digit to another digit
        // This helps avoid code repetition for min and max calculations
        // Actually, we need separate logics for max and min, because:
        // - For max, we try to remap some digit to '9' or other larger digits
        // - For min, we try to remap some digit to '0' or other smaller digits
        
        // Step 4: To make it easier, define two helper functions inside:
        // - one for maximum remapping
        // - one for minimum remapping

        // Helper to get max remapped number
        fn get_max(num_str: &str) -> i32 {
            // The idea: pick the first digit from left to right that is NOT '9'
            // Then remap all its occurrences to '9' to get the max possible number
            // If all digits are '9', remapping any digit to itself yields the same number

            // Convert to Vec<char> for easy replacement
            let chars: Vec<char> = num_str.chars().collect();

            // Find first digit not equal to '9'
            let mut target_digit = None;
            for &c in &chars {
                if c != '9' {
                    target_digit = Some(c);
                    break;
                }
            }

            // If all digits are '9', no change
            if target_digit.is_none() {
                return num_str.parse::<i32>().unwrap();
            }

            let from = target_digit.unwrap();
            let to = '9';

            // Replace all occurrences of 'from' by '9'
            let replaced: String = chars.iter()
                .map(|&c| if c == from { to } else { c })
                .collect();

            // Parse to i32 and return
            replaced.parse::<i32>().unwrap()
        }

        // Helper to get min remapped number
        fn get_min(num_str: &str) -> i32 {
            // The idea: 
            // 1. Find first digit from left that is NOT '0'
            // 2. Remap all its occurrences to '0' (which might introduce leading zeros)
            // 3. However, if the first digit is '1' and is remapped to '0', the resulting number might start with '0'
            //    which is allowed per problem statement (leading zeros allowed)
            // 4. If all digits are '0', remapping to itself yields the same number

            // Convert to Vec<char>
            let chars: Vec<char> = num_str.chars().collect();

            // Find first digit not '0'
            let mut target_digit = None;
            for &c in &chars {
                if c != '0' {
                    target_digit = Some(c);
                    break;
                }
            }

            // If all digits are '0', no change
            if target_digit.is_none() {
                return num_str.parse::<i32>().unwrap();
            }

            let from = target_digit.unwrap();
            let to = '0';

            // Replace all occurrences of 'from' by '0'
            let replaced: String = chars.iter()
                .map(|&c| if c == from { to } else { c })
                .collect();

            // Parse to i32 and return
            replaced.parse::<i32>().unwrap()
        }

        // Step 5: Get max value after remapping
        let max_val = get_max(&num_str);
        
        // Step 6: Get min value after remapping
        let min_val = get_min(&num_str);

        // Step 7: Calculate and return the difference between max and min values
        max_val - min_val
    }
}
