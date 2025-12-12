class Solution {

    /**
     * Count mentions according to rules.
     *
     * @param Integer   $n       Number of users
     * @param String[][] $events Array of events
     * @return Integer[]         Mentions per user
     */
    function countMentions($n, $events) {

        // --------------------------------------------------------------
        // mentions[u] = how many total times user u has been mentioned
        // --------------------------------------------------------------
        $mentions = array_fill(0, $n, 0);

        // --------------------------------------------------------------
        // back[u] = timestamp at which user u comes back online
        // If t < back[u] → user is offline
        // If t >= back[u] → user is online
        //
        // Initially all users are online, so back[u] = 0
        // --------------------------------------------------------------
        $back = array_fill(0, $n, 0);

        // --------------------------------------------------------------
        // Sort events:
        // 1. By increasing timestamp
        // 2. If timestamp ties:
        //      OFFLINE must be processed BEFORE MESSAGE
        //      (Python code achieved this with e[0] == "MESSAGE")
        //
        // In PHP we replicate exactly the same sort logic.
        // --------------------------------------------------------------
        usort($events, function($a, $b) {

            // Extract timestamps from event rows
            $ta = intval($a[1]);
            $tb = intval($b[1]);

            // Primary sort key = timestamp
            if ($ta !== $tb) {
                return $ta - $tb;
            }

            // Secondary sorting:
            // MESSAGE should come AFTER OFFLINE at the same time.
            // Convert type to 0/1: MESSAGE = 1, OFFLINE = 0
            $isMsgA = ($a[0] === "MESSAGE") ? 1 : 0;
            $isMsgB = ($b[0] === "MESSAGE") ? 1 : 0;

            // That means OFFLINE (0) appears first.
            return $isMsgA - $isMsgB;
        });

        // --------------------------------------------------------------
        // Process each event in sorted order.
        // --------------------------------------------------------------
        foreach ($events as $ev) {

            list($type, $tStr, $data) = $ev;

            // Convert timestamp string to integer
            $t = intval($tStr);

            // ----------------------------------------------------------
            // OFFLINE EVENT
            // ----------------------------------------------------------
            if ($type === "OFFLINE") {

                // data = user ID string (e.g. "5")
                $uid = intval($data);

                // User goes offline now and returns at t + 60
                $back[$uid] = $t + 60;

                // Nothing else to do for this event
                continue;
            }

            // ----------------------------------------------------------
            // MESSAGE EVENT
            // ----------------------------------------------------------

            // Split mentions string by spaces
            // Examples:
            //   "id3 id4"
            //   "ALL"
            //   "HERE"
            // ----------------------------------------------------------
            $tokens = explode(" ", $data);

            foreach ($tokens as $tok) {

                // ------------------------------------------------------
                // Case 1: "ALL" → mention EVERY user.
                // Offline or online doesn't matter.
                // ------------------------------------------------------
                if ($tok === "ALL") {
                    for ($u = 0; $u < $n; $u++) {
                        $mentions[$u]++;
                    }
                    continue;
                }

                // ------------------------------------------------------
                // Case 2: "HERE" → mention ONLY online users.
                // User u is online if t >= back[u].
                // ------------------------------------------------------
                if ($tok === "HERE") {
                    for ($u = 0; $u < $n; $u++) {
                        if ($t >= $back[$u]) {  // online
                            $mentions[$u]++;
                        }
                    }
                    continue;
                }

                // ------------------------------------------------------
                // Case 3: "id<u>"
                // Direct mention of a specific user.
                // Extract the numeric ID after "id".
                // ------------------------------------------------------
                if (strpos($tok, "id") === 0) {
                    $uid = intval(substr($tok, 2));   // remove "id"
                    $mentions[$uid]++;
                    continue;
                }

                // Any other token is impossible under problem constraints.
            }
        }

        // --------------------------------------------------------------
        // Return final mention counts
        // --------------------------------------------------------------
        return $mentions;
    }
}
