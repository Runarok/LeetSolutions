class Solution {

    /**
     * @param String[]  $code
     * @param String[]  $businessLine
     * @param Boolean[] $isActive
     * @return String[]
     */
    function validateCoupons($code, $businessLine, $isActive) {

        // Final result list
        $list = [];

        // Separate lists for each business line
        $liste = []; // electronics
        $listg = []; // grocery
        $listp = []; // pharmacy
        $listr = []; // restaurant

        // Iterate through all coupons
        for ($i = 0; $i < count($code); $i++) {

            $cur = $code[$i];

            // Skip empty codes
            if ($cur === "") continue;

            // Check if code contains only letters, digits, or underscore
            if (!$this->stringCheck($cur)) continue;

            // Check business line and active status
            if ($businessLine[$i] === "electronics" && $isActive[$i]) {
                $liste[] = $cur;
            }
            if ($businessLine[$i] === "grocery" && $isActive[$i]) {
                $listg[] = $cur;
            }
            if ($businessLine[$i] === "pharmacy" && $isActive[$i]) {
                $listp[] = $cur;
            }
            if ($businessLine[$i] === "restaurant" && $isActive[$i]) {
                $listr[] = $cur;
            }
        }

        // Sort each category lexicographically
        sort($liste, SORT_STRING);
        sort($listg, SORT_STRING);
        sort($listp, SORT_STRING);
        sort($listr, SORT_STRING);

        // Merge results in required business-line order
        array_push($list, ...$liste);
        array_push($list, ...$listg);
        array_push($list, ...$listp);
        array_push($list, ...$listr);

        return $list;
    }

    /**
     * Check if string contains only alphanumeric characters or underscore
     *
     * @param String $cur
     * @return Boolean
     */
    function stringCheck($cur) {
        for ($i = 0; $i < strlen($cur); $i++) {
            $c = $cur[$i];
            if (!(ctype_alnum($c) || $c === '_')) {
                return false;
            }
        }
        return true;
    }
}
