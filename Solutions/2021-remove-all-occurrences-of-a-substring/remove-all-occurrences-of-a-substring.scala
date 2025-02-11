object Solution {
  def removeOccurrences(s: String, part: String): String = {
    var result = s
    while (result.contains(part)) {
      result = result.replaceFirst(part, "")
    }
    result
  }
}
