function totalWaviness(num1: number, num2: number): number {

    // Calculates waviness of a single number.
    function getWaviness(num: number): number {

        // Convert number into array of digits.
        const digits = String(num).split("").map(Number);

        // Numbers with less than 3 digits
        // can never have peaks or valleys.
        if (digits.length < 3) {
            return 0;
        }

        let waviness = 0;

        // First and last digits cannot be peaks/valleys,
        // so only check middle positions.
        for (let i = 1; i < digits.length - 1; i++) {

            const left = digits[i - 1];
            const curr = digits[i];
            const right = digits[i + 1];

            // Current digit is strictly larger
            // than both neighbors.
            const isPeak =
                curr > left &&
                curr > right;

            // Current digit is strictly smaller
            // than both neighbors.
            const isValley =
                curr < left &&
                curr < right;

            if (isPeak || isValley) {
                waviness++;
            }
        }

        return waviness;
    }

    let answer = 0;

    // Check every number in the range.
    for (let num = num1; num <= num2; num++) {

        // Add this number's waviness
        // to the overall total.
        answer += getWaviness(num);
    }

    return answer;
}