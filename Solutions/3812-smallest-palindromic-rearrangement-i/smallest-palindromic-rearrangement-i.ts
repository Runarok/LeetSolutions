function smallestPalindrome(s: string): string {
    // Frequency array for 26 lowercase English letters
    const freq = new Array(26).fill(0);

    // Count occurrences of each character
    for (const ch of s) {
        freq[ch.charCodeAt(0) - 97]++;
    }

    // Stores the first half of the palindrome
    const left: string[] = [];

    // Stores the middle character (if any)
    let middle = "";

    // Build the left half in lexicographical order
    for (let i = 0; i < 26; i++) {
        const count = freq[i];
        const ch = String.fromCharCode(97 + i);

        // Add half of the occurrences to the left side
        for (let j = 0; j < Math.floor(count / 2); j++) {
            left.push(ch);
        }

        // If frequency is odd, this becomes the middle character
        if (count % 2 === 1) {
            middle = ch;
        }
    }

    // Right half is simply the reverse of the left half
    const right = [...left].reverse().join("");

    // Construct the smallest palindrome
    return left.join("") + middle + right;
}