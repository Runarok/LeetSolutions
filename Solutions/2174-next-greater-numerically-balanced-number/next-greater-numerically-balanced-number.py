class Solution:
    def nextBeautifulNumber(self, n: int) -> int:
        # Helper function to check if a number is numerically balanced
        def is_balanced(num: int) -> bool:
            # Convert number to string to easily count digits
            s = str(num)
            # Count frequency of each digit
            freq = {}
            for ch in s:
                freq[ch] = freq.get(ch, 0) + 1

            # Check if for each digit d, frequency == d
            for d, count in freq.items():
                if int(d) != count:
                    return False
            return True

        # Start checking numbers strictly greater than n
        candidate = n + 1

        # Since the largest n ≤ 10^6, we can safely brute-force upwards
        while True:
            # Check if the candidate number is numerically balanced
            if is_balanced(candidate):
                return candidate
            candidate += 1
