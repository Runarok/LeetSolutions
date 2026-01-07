class Solution {
    func reformatDate(_ date: String) -> String {
        // Split the date into components: Day, Month, Year
        let parts = date.split(separator: " ")
        
        // Extract year
        let year = String(parts[2])
        
        // Extract day by removing non-digit characters (st, nd, rd, th)
        let dayNumber = parts[0].filter { $0.isNumber }
        let day = dayNumber.count == 1 ? "0" + dayNumber : String(dayNumber)
        
        // Month mapping
        let monthMap: [String: String] = [
            "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
            "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
            "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"
        ]
        
        let month = monthMap[String(parts[1])]!
        
        // Return formatted date
        return "\(year)-\(month)-\(day)"
    }
}
