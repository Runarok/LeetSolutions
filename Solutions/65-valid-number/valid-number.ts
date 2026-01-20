function isNumber(s: string): boolean {
    // Trim spaces at both ends (optional for safety)
    s = s.trim();

    if (s.length === 0) return false;

    // Flags to track state
    let seenDigit = false;       // at least one digit in current number
    let seenDot = false;         // a decimal point '.'
    let seenExp = false;         // exponent 'e' or 'E'

    for (let i = 0; i < s.length; i++) {
        const c = s[i];

        if (c >= '0' && c <= '9') {
            // Digits are always valid
            seenDigit = true;
        } 
        else if (c === '.') {
            // Only one dot allowed and it cannot appear after exponent
            if (seenDot || seenExp) return false;
            seenDot = true;
        } 
        else if (c === 'e' || c === 'E') {
            // Exponent must appear only once and must follow a digit
            if (seenExp || !seenDigit) return false;
            seenExp = true;
            seenDigit = false; // reset for digits after 'e'
        } 
        else if (c === '+' || c === '-') {
            // Sign is valid only at start or immediately after 'e'/'E'
            if (i > 0 && s[i - 1] !== 'e' && s[i - 1] !== 'E') return false;
        } 
        else {
            // Any other character is invalid
            return false;
        }
    }

    // Must have at least one digit (for exponent part too)
    return seenDigit;
}
