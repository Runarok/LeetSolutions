function mostBooked(n: number, meetings: number[][]): number {
    // Sort meetings by their original start time
    meetings.sort((a, b) => a[0] - b[0]);

    // Count how many meetings each room holds
    const meetingCount: number[] = new Array(n).fill(0);

    // -------------------------------
    // Min-heap for available rooms
    // Stores room numbers
    // -------------------------------
    const availableRooms: number[] = [];
    for (let i = 0; i < n; i++) {
        availableRooms.push(i);
    }

    // Helper function to keep availableRooms as a min-heap
    availableRooms.sort((a, b) => a - b);

    // -------------------------------
    // Min-heap for busy rooms
    // Each element: [endTime, roomNumber]
    // Sorted by endTime first, then roomNumber
    // -------------------------------
    const busyRooms: [number, number][] = [];

    // Helper function to push into busyRooms heap
    const pushBusy = (item: [number, number]) => {
        busyRooms.push(item);
        busyRooms.sort((a, b) => {
            if (a[0] !== b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });
    };

    // Helper function to pop from busyRooms heap
    const popBusy = () => busyRooms.shift()!;

    // Helper function to push into availableRooms heap
    const pushAvailable = (room: number) => {
        availableRooms.push(room);
        availableRooms.sort((a, b) => a - b);
    };

    // -----------------------------------
    // Process each meeting one by one
    // -----------------------------------
    for (const [start, end] of meetings) {
        const duration = end - start;

        // Free up rooms that have finished by 'start'
        while (busyRooms.length > 0 && busyRooms[0][0] <= start) {
            const [_, room] = popBusy();
            pushAvailable(room);
        }

        // If we have a free room
        if (availableRooms.length > 0) {
            // Use the lowest-numbered available room
            const room = availableRooms.shift()!;
            meetingCount[room]++;
            pushBusy([end, room]);
        } 
        // Otherwise, all rooms are busy → delay the meeting
        else {
            // Get the room that finishes earliest
            const [earliestEnd, room] = popBusy();

            // Meeting starts when this room becomes free
            const newEnd = earliestEnd + duration;

            meetingCount[room]++;
            pushBusy([newEnd, room]);
        }
    }

    // -----------------------------------
    // Find the room with the most meetings
    // -----------------------------------
    let maxMeetings = 0;
    let answerRoom = 0;

    for (let i = 0; i < n; i++) {
        if (meetingCount[i] > maxMeetings) {
            maxMeetings = meetingCount[i];
            answerRoom = i;
        }
    }

    return answerRoom;
}
