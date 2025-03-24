/**
 * @param {number} days
 * @param {number[][]} meetings
 * @return {number}
 */
var countDays = function(days, meetings) {
    // Create a list of intervals from the meeting times
    let intervals = [];
    
    // Add the meeting intervals into the list
    for (let meeting of meetings) {
        intervals.push([meeting[0], meeting[1]]);
    }
    
    // Sort the intervals based on the start day
    intervals.sort((a, b) => a[0] - b[0]);

    // Variable to track the number of free days
    let freeDays = 0;
    
    // Variable to track the last end day of a meeting
    let lastEndDay = 0;

    // Iterate over the sorted intervals
    for (let [start, end] of intervals) {
        // If the meeting starts after the last meeting's end day, count the free days
        if (start > lastEndDay) {
            freeDays += start - lastEndDay - 1;
        }
        
        // Update the last end day to be the maximum of the current end day or the last end day
        lastEndDay = Math.max(lastEndDay, end);
    }

    // After processing all meetings, count the free days after the last meeting
    if (lastEndDay < days) {
        freeDays += days - lastEndDay;
    }

    return freeDays;
};
