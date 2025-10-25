class Solution:
    def totalMoney(self, n: int) -> int:
        # Each week has 7 days (Monday to Sunday)
        days_per_week = 7
        
        # Calculate the number of full weeks and remaining days
        full_weeks = n // days_per_week
        remaining_days = n % days_per_week
        
        # Initialize total amount
        total = 0
        
        # 1️⃣ Add money from all *full weeks*
        # For week 0 (first week), deposits are: 1, 2, 3, 4, 5, 6, 7  -> sum = 28
        # For week 1 (second week), deposits are: 2, 3, 4, 5, 6, 7, 8  -> sum = 35
        # Generally, week k (0-indexed) starts from (1 + k)
        # Sum of week k = 7 * (starting number) + sum of (0 to 6)
        #                = 7 * (1 + k) + 21 = 28 + 7k
        #
        # So we can compute the total for all full weeks using the arithmetic series formula
        # total_full_weeks = sum of (28 + 7k) for k = 0 to full_weeks - 1
        total += full_weeks * 28 + 7 * (full_weeks * (full_weeks - 1)) // 2
        
        # 2️⃣ Add money from the *remaining days* (partial week)
        # After full_weeks, the next Monday’s starting value will be (1 + full_weeks)
        start = 1 + full_weeks
        
        # Add for each remaining day
        for day in range(remaining_days):
            total += start + day  # Each day increases by 1
        
        return total
         