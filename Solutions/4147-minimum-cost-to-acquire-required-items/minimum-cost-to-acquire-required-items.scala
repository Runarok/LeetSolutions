
object Solution {
    def minimumCost(
        cost1: Int,
        cost2: Int,
        costBoth: Int,
        need1: Int,
        need2: Int
    ): Long = {

        // Convert requirements to Long to avoid integer overflow.
        val n1 = need1.toLong
        val n2 = need2.toLong

        // Convert costs to Long for safe multiplication.
        val c1 = cost1.toLong
        val c2 = cost2.toLong
        val cb = costBoth.toLong

        // Strategy 1:
        // Buy only individual type 1 and type 2 items.
        //
        // We purchase exactly need1 type 1 items
        // and need2 type 2 items.
        val option1 = (n1 * c1) + (n2 * c2)

        // Strategy 2:
        // Buy type 3 items for the common requirement.
        //
        // The common requirement is the minimum of need1 and need2.
        // Each type 3 item satisfies both requirements by 1.
        //
        // After that, purchase individual items
        // for whichever requirement is still remaining.
        val common = math.min(n1, n2)

        val remaining1 = n1 - common
        val remaining2 = n2 - common

        val option2 =
            (common * cb) +
            (remaining1 * c1) +
            (remaining2 * c2)

        // Strategy 3:
        // Buy only type 3 items.
        //
        // We purchase max(need1, need2) type 3 items.
        // This guarantees that BOTH requirements are satisfied.
        //
        // One requirement might receive extra units,
        // but that is allowed because we only need AT LEAST
        // the required number of units.
        val option3 = math.max(n1, n2) * cb

        // Return the cheapest among all three strategies.
        math.min(option1, math.min(option2, option3))
    }
}
