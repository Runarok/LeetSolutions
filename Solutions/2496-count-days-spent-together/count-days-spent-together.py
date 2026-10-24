class Solution:
    def countDaysTogether(self, arriveAlice: str, leaveAlice: str, arriveBob: str, leaveBob: str) -> int:
        # Define the number of days in each month for a non-leap year
        days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        # Helper function to convert an "MM-DD" date string into the day of the year (1-365)
        def date_to_day_of_year(date_str: str) -> int:
            month, day = map(int, date_str.split("-"))
            
            # Sum up the days of all previous months
            total_days = sum(days_in_months[:month - 1])
            
            # Add the current day of the month
            total_days += day
            
            return total_days

        # Convert Alice's arrival and departure dates to day-of-year integers
        alice_arrive_day = date_to_day_of_year(arriveAlice)
        alice_leave_day = date_to_day_of_year(leaveAlice)
        
        # Convert Bob's arrival and departure dates to day-of-year integers
        bob_arrive_day = date_to_day_of_year(arriveBob)
        bob_leave_day = date_to_day_of_year(leaveBob)
        
        # Find the overlap period between their stays
        # The overlap starts on the later of the two arrival dates
        overlap_arrive = max(alice_arrive_day, bob_arrive_day)
        
        # The overlap ends on the earlier of the two departure dates
        overlap_leave = min(alice_leave_day, bob_leave_day)
        
        # Calculate the total number of overlapping days
        # If overlap_arrive <= overlap_leave, they share at least one day together.
        # Otherwise, there is no overlap, and they share 0 days.
        if overlap_arrive <= overlap_leave:
            return overlap_leave - overlap_arrive + 1
        else:
            return 0