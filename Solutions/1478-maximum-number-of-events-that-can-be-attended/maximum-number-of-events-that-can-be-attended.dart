import 'package:collection/collection.dart';

class Solution {
  int maxEvents(List<List<int>> events) {
    // Step 1: Sort events by their start day
    events.sort((a, b) => a[0].compareTo(b[0]));

    // Step 2: Use a min-heap to track events by their end day
    var minHeap = HeapPriorityQueue<int>();

    int res = 0;  // To count events attended
    int i = 0;    // Pointer for the events list
    int n = events.length;

    // Step 3: Find the last day any event can end
    int lastDay = events.map((e) => e[1]).reduce((a, b) => a > b ? a : b);

    // Step 4: Iterate over each day
    for (int day = 1; day <= lastDay; day++) {
      // Add all events starting today
      while (i < n && events[i][0] == day) {
        minHeap.add(events[i][1]);  // Add end day of the event
        i++;
      }

      // Remove events that have already ended
      while (minHeap.isNotEmpty && minHeap.first < day) {
        minHeap.removeFirst();
      }

      // Attend the event with earliest end time
      if (minHeap.isNotEmpty) {
        minHeap.removeFirst();
        res++;
      }
    }

    return res;
  }
}
