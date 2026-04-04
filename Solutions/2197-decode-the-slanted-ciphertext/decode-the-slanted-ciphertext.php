<?php
class Solution {

    /**
     * Function to decode a slanted ciphertext.
     *
     * @param String $encodedText - The encoded string containing spaces.
     * @param Integer $rows - Number of rows used during encoding.
     * @return String - The decoded original message.
     */
    public function decodeCiphertext($encodedText, $rows) {

        // Total number of characters in the encoded string
        $length = strlen($encodedText);

        // Calculate number of columns.
        // Since the string was filled row-wise, columns = length / rows
        // ceil is used in case it's not perfectly divisible.
        $cols = ceil($length / $rows);

        // Create an empty 2D matrix (rows x cols)
        // Fill initially with spaces
        $matrix = array_fill(0, $rows, array_fill(0, $cols, ' '));

        // -----------------------------------------
        // STEP 1: Fill the matrix row-wise
        // -----------------------------------------
        // We simulate how the encoded text was stored
        // Each row is filled left → right
        // Move to next row once a row is filled

        $index = 0; // Pointer for encodedText

        for ($i = 0; $i < $rows; $i++) {           // Loop through rows
            for ($j = 0; $j < $cols; $j++) {       // Loop through columns

                // Stop if we run out of characters
                if ($index >= $length) {
                    break;
                }

                // Place character into matrix
                $matrix[$i][$j] = $encodedText[$index];

                // Move to next character
                $index++;
            }
        }

        // -----------------------------------------
        // STEP 2: Read diagonally (top-left → bottom-right)
        // -----------------------------------------
        // This reconstructs the original message.
        // Start from each column in the first row.
        // Then move diagonally down-right.

        $decodedMessage = '';

        // Each starting point is a column in row 0
        for ($start = 0; $start < $cols; $start++) {

            $i = 0;           // Start from first row
            $j = $start;      // Start column shifts each iteration

            // Traverse diagonally
            while ($i < $rows && $j < $cols) {

                // Append current character
                $decodedMessage .= $matrix[$i][$j];

                // Move diagonally: down one row, right one column
                $i++;
                $j++;
            }
        }

        // -----------------------------------------
        // STEP 3: Remove trailing spaces
        // -----------------------------------------
        // Some extra spaces may appear at the end
        // rtrim removes them from the right side

        return rtrim($decodedMessage);
    }
}
?>