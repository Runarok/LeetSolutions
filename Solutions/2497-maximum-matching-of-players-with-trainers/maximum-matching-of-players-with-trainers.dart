class Solution {
  int matchPlayersAndTrainers(List<int> players, List<int> trainers) {
    // Sort both players and trainers in ascending order
    players.sort();
    trainers.sort();

    int m = players.length;
    int n = trainers.length;

    int count = 0; // Counter to keep track of successful matches
    int i = 0;     // Pointer for players
    int j = 0;     // Pointer for trainers

    // Loop until either list is exhausted
    while (i < m && j < n) {
      // If current trainer can handle current player
      if (players[i] <= trainers[j]) {
        count++; // Successful match
        i++;     // Move to next player
        j++;     // Move to next trainer
      } else {
        // Trainer too weak, try the next one
        j++;
      }
    }

    // Return the total number of matches made
    return count;
  }
}
