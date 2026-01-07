class MyCalendarTwo {
private:
    vector<pair<int,int>> calendar; // all single bookings
    vector<pair<int,int>> overlaps; // all double bookings

public:
    MyCalendarTwo() {
        calendar.clear();
        overlaps.clear();
    }
    
    bool book(int startTime, int endTime) {
        // STEP 1: Check for triple booking
        for (auto &p : overlaps) {
            int l = max(startTime, p.first);
            int r = min(endTime, p.second);
            if (l < r) { // overlap exists → triple booking
                return false;
            }
        }
        
        // STEP 2: Record new double bookings
        for (auto &p : calendar) {
            int l = max(startTime, p.first);
            int r = min(endTime, p.second);
            if (l < r) { // overlap exists → becomes double booked
                overlaps.push_back({l, r});
            }
        }
        
        // STEP 3: Add new single booking
        calendar.push_back({startTime, endTime});
        return true;
    }
};


/**
 * Your MyCalendarTwo object will be instantiated and called as such:
 * MyCalendarTwo* obj = new MyCalendarTwo();
 * bool param_1 = obj->book(startTime,endTime);
 */