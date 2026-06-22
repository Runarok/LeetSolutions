impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        // Frequency array for all lowercase English letters.
        // freq[0] -> count of 'a'
        // freq[1] -> count of 'b'
        // ...
        // freq[25] -> count of 'z'
        let mut freq = [0; 26];

        // Count occurrences of each character in the input string.
        for ch in text.chars() {
            freq[(ch as u8 - b'a') as usize] += 1;
        }

        // To form the word "balloon", we need:
        //
        // b -> 1 time
        // a -> 1 time
        // l -> 2 times
        // o -> 2 times
        // n -> 1 time
        //
        // The number of complete "balloon" words we can build
        // is limited by the character that runs out first.

        // Count of 'b'
        let b = freq[(b'b' - b'a') as usize];

        // Count of 'a'
        let a = freq[(b'a' - b'a') as usize];

        // Count of 'l'
        // Since "balloon" needs 2 l's,
        // divide the available count by 2.
        let l = freq[(b'l' - b'a') as usize] / 2;

        // Count of 'o'
        // Since "balloon" needs 2 o's,
        // divide the available count by 2.
        let o = freq[(b'o' - b'a') as usize] / 2;

        // Count of 'n'
        let n = freq[(b'n' - b'a') as usize];

        // The answer is the minimum among all required characters.
        // Example:
        // b = 3, a = 5, l = 2, o = 4, n = 7
        // -> only 2 complete "balloon" words can be formed.
        b.min(a).min(l).min(o).min(n)
    }
}