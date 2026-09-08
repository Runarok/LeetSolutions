class Solution:
    def countCommas(self, n: int) -> int:
        # Numbers below 1,000 have no commas.
        if n < 1000:
            return 0

        # Every number from 1,000 through n has one comma
        # for the range covered by this problem.
        #
        # There are:
        # n - 1000 + 1
        # numbers in this range.
        return n - 999
