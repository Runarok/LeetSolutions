function fullJustify(words: string[], maxWidth: number): string[] {
    // result array that will store all fully formatted lines
    const result: string[] = [];

    // index pointer to iterate through words
    let i = 0;

    // iterate until all words are processed
    while (i < words.length) {
        // lineWords will store words that fit in the current line
        const lineWords: string[] = [];

        // total length of words (without spaces) in the current line
        let lineLen = 0;

        // greedily add as many words as possible to the current line
        while (
            i < words.length &&
            lineLen + lineWords.length + words[i].length <= maxWidth
        ) {
            // add word to line
            lineWords.push(words[i]);

            // add word length to total length
            lineLen += words[i].length;

            // move to next word
            i++;
        }

        // number of gaps between words in the current line
        const gaps = lineWords.length - 1;

        // check if this is the last line OR the line has only one word
        if (i === words.length || gaps === 0) {
            // left-justify the line

            // join words with a single space
            let line = lineWords.join(" ");

            // pad remaining spaces to the right to reach maxWidth
            line += " ".repeat(maxWidth - line.length);

            // push the formatted line to result
            result.push(line);
        } else {
            // fully justify the line

            // total spaces that need to be distributed
            const totalSpaces = maxWidth - lineLen;

            // minimum spaces per gap
            const spacePerGap = Math.floor(totalSpaces / gaps);

            // extra spaces that need to be distributed to the left gaps
            let extraSpaces = totalSpaces % gaps;

            // string builder for the line
            let line = "";

            // build the line word by word
            for (let j = 0; j < lineWords.length; j++) {
                // add the word
                line += lineWords[j];

                // if not the last word, add spaces
                if (j < gaps) {
                    // base spaces for every gap
                    let spaces = spacePerGap;

                    // distribute extra spaces to the left gaps
                    if (extraSpaces > 0) {
                        spaces++;
                        extraSpaces--;
                    }

                    // append spaces
                    line += " ".repeat(spaces);
                }
            }

            // push the fully justified line to result
            result.push(line);
        }
    }

    // return all justified lines
    return result;
}
