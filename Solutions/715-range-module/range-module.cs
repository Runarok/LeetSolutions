using System;
using System.Collections.Generic;

public class RangeModule
{
    // SortedDictionary to track intervals
    // Key: interval start, Value: interval end (exclusive)
    private SortedDictionary<int, int> intervals;

    public RangeModule()
    {
        intervals = new SortedDictionary<int, int>();
    }

    /// <summary>
    /// Add the half-open interval [left, right) to the tracked intervals.
    /// Merge with any overlapping intervals.
    /// </summary>
    public void AddRange(int left, int right)
    {
        if (left >= right) return;

        // Find intervals that may overlap with [left, right)
        var toRemove = new List<int>();

        foreach (var kvp in intervals)
        {
            int start = kvp.Key;
            int end = kvp.Value;

            // If the interval is completely after the new range, break early
            if (start > right) break;

            // If there is overlap
            if (end >= left)
            {
                left = Math.Min(left, start);  // expand left bound
                right = Math.Max(right, end);  // expand right bound
                toRemove.Add(start);           // mark existing interval to remove
            }
        }

        // Remove merged intervals
        foreach (var start in toRemove)
        {
            intervals.Remove(start);
        }

        // Add the new merged interval
        intervals[left] = right;
    }

    /// <summary>
    /// Remove the half-open interval [left, right) from tracked intervals.
    /// May split existing intervals if necessary.
    /// </summary>
    public void RemoveRange(int left, int right)
    {
        if (left >= right) return;

        var toAdd = new List<(int start, int end)>();
        var toRemove = new List<int>();

        foreach (var kvp in intervals)
        {
            int start = kvp.Key;
            int end = kvp.Value;

            // No overlap
            if (end <= left) continue;
            if (start >= right) break;

            // Overlap exists, mark for removal
            toRemove.Add(start);

            // Add left part if it exists
            if (start < left)
                toAdd.Add((start, left));

            // Add right part if it exists
            if (end > right)
                toAdd.Add((right, end));
        }

        // Remove overlapping intervals
        foreach (var start in toRemove)
            intervals.Remove(start);

        // Add adjusted intervals
        foreach (var interval in toAdd)
            intervals[interval.start] = interval.end;
    }

    /// <summary>
    /// Query if the interval [left, right) is completely covered by tracked intervals.
    /// </summary>
    public bool QueryRange(int left, int right)
    {
        if (left >= right) return false;

        // Find the interval with the largest start <= left
        int startToCheck = -1;
        foreach (var kvp in intervals)
        {
            if (kvp.Key <= left)
                startToCheck = kvp.Key;
            else
                break;
        }

        if (startToCheck == -1) return false;

        return intervals[startToCheck] >= right;
    }
}

/**
Example Usage:

RangeModule rm = new RangeModule();
rm.AddRange(10, 20);    // Track [10,20)
rm.RemoveRange(14, 16); // Remove [14,16)
rm.QueryRange(10, 14);  // true
rm.QueryRange(13, 15);  // false
rm.QueryRange(16, 17);  // true
*/

