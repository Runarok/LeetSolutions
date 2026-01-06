class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        let targetTickets = tickets[k]
        var time = 0
        
        for i in 0..<tickets.count {
            if i <= k {
                // People before or at k: contribute min(their tickets, tickets[k])
                time += min(tickets[i], targetTickets)
            } else {
                // People after k: contribute min(their tickets, tickets[k]-1)
                time += min(tickets[i], targetTickets - 1)
            }
        }
        
        return time
    }
}
