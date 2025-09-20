/**
 * Your Router object will be instantiated and called as such:
 * obj := Constructor(memoryLimit);
 * param_1 := obj.AddPacket(source,destination,timestamp);
 * param_2 := obj.ForwardPacket();
 * param_3 := obj.GetCount(destination,startTime,endTime);
 */

 package main

import (
    "sort"
    "strconv"
)

type Packet struct {
    source      int
    destination int
    timestamp   int
}

type Router struct {
    memoryLimit int

    queue []Packet // Queue for FIFO processing

    seen map[string]struct{} // Set to track duplicates using unique key

    // Maps destination → sorted list of timestamps for fast range counting
    destMap map[int][]int
}

// Helper to generate unique string key for deduplication
func makeKey(source, destination, timestamp int) string {
    return strconv.Itoa(source) + ":" + strconv.Itoa(destination) + ":" + strconv.Itoa(timestamp)
}

// Constructor initializes Router with memoryLimit
func Constructor(memoryLimit int) Router {
    return Router{
        memoryLimit: memoryLimit,
        queue:       []Packet{},
        seen:        make(map[string]struct{}),
        destMap:     make(map[int][]int),
    }
}

// Adds a packet, returns true if added (not duplicate), else false
func (this *Router) AddPacket(source int, destination int, timestamp int) bool {
    key := makeKey(source, destination, timestamp)

    // Check for duplicate
    if _, exists := this.seen[key]; exists {
        return false
    }

    // Create and add the packet
    packet := Packet{source, destination, timestamp}
    this.queue = append(this.queue, packet)
    this.seen[key] = struct{}{}

    // Append timestamp to destination map (timestamps always increasing)
    this.destMap[destination] = append(this.destMap[destination], timestamp)

    // If memory limit exceeded, remove the oldest packet (FIFO)
    if len(this.queue) > this.memoryLimit {
        oldest := this.queue[0]
        this.queue = this.queue[1:]

        oldestKey := makeKey(oldest.source, oldest.destination, oldest.timestamp)
        delete(this.seen, oldestKey)

        // Remove timestamp from destination map
        timestamps := this.destMap[oldest.destination]
        idx := sort.SearchInts(timestamps, oldest.timestamp)
        if idx < len(timestamps) && timestamps[idx] == oldest.timestamp {
            // Remove from slice
            this.destMap[oldest.destination] = append(timestamps[:idx], timestamps[idx+1:]...)
        }
    }

    return true
}

// Forwards (removes and returns) next packet in FIFO
func (this *Router) ForwardPacket() []int {
    if len(this.queue) == 0 {
        return []int{}
    }

    packet := this.queue[0]
    this.queue = this.queue[1:]

    key := makeKey(packet.source, packet.destination, packet.timestamp)
    delete(this.seen, key)

    // Remove timestamp from destination map
    timestamps := this.destMap[packet.destination]
    idx := sort.SearchInts(timestamps, packet.timestamp)
    if idx < len(timestamps) && timestamps[idx] == packet.timestamp {
        this.destMap[packet.destination] = append(timestamps[:idx], timestamps[idx+1:]...)
    }

    return []int{packet.source, packet.destination, packet.timestamp}
}

// Returns count of packets with destination in [startTime, endTime]
func (this *Router) GetCount(destination int, startTime int, endTime int) int {
    timestamps := this.destMap[destination]
    if len(timestamps) == 0 {
        return 0
    }

    // Binary search for lower and upper bounds
    left := sort.SearchInts(timestamps, startTime)
    right := sort.Search(len(timestamps), func(i int) bool {
        return timestamps[i] > endTime
    })

    return right - left
}
