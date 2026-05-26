function numberOfSpecialChars(word: string): number {
    // Set to store all lowercase letters found
    const lowerCaseLetters = new Set<string>();

    // Set to store all uppercase letters found
    const upperCaseLetters = new Set<string>();

    // Loop through every character in the word
    for (const ch of word) {

        // Check if character is lowercase
        // If true, add it to lowercase set
        if (ch >= 'a' && ch <= 'z') {
            lowerCaseLetters.add(ch);
        } 
        // Otherwise it must be uppercase
        else {
            upperCaseLetters.add(ch);
        }
    }

    // Variable to count special characters
    let specialCount = 0;

    // Check every lowercase character
    for (const ch of lowerCaseLetters) {

        // Convert lowercase to uppercase
        const upperVersion = ch.toUpperCase();

        // If uppercase version exists in uppercase set
        // then this character is special
        if (upperCaseLetters.has(upperVersion)) {
            specialCount++;
        }
    }

    // Return total special characters
    return specialCount;
}