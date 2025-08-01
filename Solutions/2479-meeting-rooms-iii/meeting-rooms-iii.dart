class Solution {
  int mostBooked(int n, List<List<int>> meetings) {
    // List to keep track of when each room becomes available
    List<int> roomAvailabilityTime = List.filled(n, 0);

    // List to count how many meetings each room has handled
    List<int> meetingCount = List.filled(n, 0);

    // Sort meetings by their start time
    meetings.sort((a, b) => a[0].compareTo(b[0]));

    for (var meeting in meetings) {
      int start = meeting[0];
      int end = meeting[1];

      // Track the soonest available room (in case all are busy)
      int minRoomAvailabilityTime = 1 << 60; // A large number (simulating infinity)
      int minAvailableTimeRoom = 0;

      // Flag to indicate if a room was found that can host the meeting immediately
      bool foundUnusedRoom = false;

      // Try to find a room that is free by the start of the meeting
      for (int i = 0; i < n; i++) {
        if (roomAvailabilityTime[i] <= start) {
          // Room is free for use
          foundUnusedRoom = true;
          roomAvailabilityTime[i] = end; // Book the room until meeting end
          meetingCount[i]++; // Increase its meeting count
          break; // Exit the loop since we've found a free room
        }

        // Track the room that becomes free the soonest
        if (roomAvailabilityTime[i] < minRoomAvailabilityTime) {
          minRoomAvailabilityTime = roomAvailabilityTime[i];
          minAvailableTimeRoom = i;
        }
      }

      // If no room was immediately available, delay the meeting
      if (!foundUnusedRoom) {
        // Schedule the meeting to start after the room becomes free
        roomAvailabilityTime[minAvailableTimeRoom] += (end - start);
        meetingCount[minAvailableTimeRoom]++;
      }
    }

    // Find the room with the highest number of meetings
    int maxMeetings = meetingCount[0];
    int resultRoom = 0;

    for (int i = 1; i < n; i++) {
      if (meetingCount[i] > maxMeetings) {
        maxMeetings = meetingCount[i];
        resultRoom = i;
      }
    }

    // Return the room number that handled the most meetings
    return resultRoom;
  }
}
