using System;
using System.Collections.Generic;

public class SummaryRanges
{
    // List of intervals [start, end]
    private List<int[]> intervals;

    public SummaryRanges()
    {
        intervals = new List<int[]>();
    }

    public void AddNum(int value)
    {
        int n = intervals.Count;
        int left = 0, right = n - 1;

        // Binary search to find the interval where 'value' could go
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (intervals[mid][0] <= value && value <= intervals[mid][1])
            {
                // Already covered in existing interval
                return;
            }
            else if (value < intervals[mid][0])
            {
                right = mid - 1;
            }
            else
            {
                left = mid + 1;
            }
        }

        // Now left is the position to insert new interval
        int newStart = value;
        int newEnd = value;

        // Check if it can merge with previous interval
        if (right >= 0 && intervals[right][1] + 1 >= value)
        {
            newStart = intervals[right][0];
            newEnd = Math.Max(intervals[right][1], value);
            intervals.RemoveAt(right);
            left--; // adjust insertion index
        }

        // Check if it can merge with next interval
        if (left < intervals.Count && intervals[left][0] - 1 <= value)
        {
            newStart = Math.Min(newStart, intervals[left][0]);
            newEnd = Math.Max(newEnd, intervals[left][1]);
            intervals.RemoveAt(left);
        }

        // Insert the merged/new interval
        intervals.Insert(left, new int[] { newStart, newEnd });
    }

    public int[][] GetIntervals()
    {
        return intervals.ToArray();
    }
}
