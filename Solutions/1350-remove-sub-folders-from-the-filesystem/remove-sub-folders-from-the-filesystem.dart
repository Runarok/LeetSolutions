class Solution {
  List<String> removeSubfolders(List<String> folder) {
    // Use a Set for fast lookup of folder paths
    final Set<String> folderSet = folder.toSet();
    final List<String> result = [];

    // Iterate through each folder path
    for (final f in folder) {
      bool isSubFolder = false;
      String prefix = f;

      // Check for parent folders by trimming the path
      while (prefix.isNotEmpty) {
        int pos = prefix.lastIndexOf('/');
        if (pos == -1) break;

        prefix = prefix.substring(0, pos);

        // If a parent folder exists, it's a sub-folder
        if (folderSet.contains(prefix)) {
          isSubFolder = true;
          break;
        }
      }

      // Add to result if not a sub-folder
      if (!isSubFolder) {
        result.add(f);
      }
    }

    return result;
  }
}
