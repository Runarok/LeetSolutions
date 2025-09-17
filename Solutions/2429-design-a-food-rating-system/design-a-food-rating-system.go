package main

import (
	"container/heap"
	"fmt"
)

///////////////////////////////////////////////////////////////////////////////
//                          STRUCTURES AND DATA TYPES                       //
///////////////////////////////////////////////////////////////////////////////

// FoodRatings is the main structure that manages all the food ratings and queries.
type FoodRatings struct {
	foodToCuisine map[string]string    // Maps each food to its cuisine
	foodToRating  map[string]int       // Maps each food to its current rating
	cuisineHeaps  map[string]*FoodHeap // Maps each cuisine to a max heap of foods
}

// Food represents a single food item with its name and rating.
type Food struct {
	name   string // Name of the food
	rating int    // Rating of the food
}

// FoodHeap is a max-heap of foods for a specific cuisine.
// It prioritizes:
// 1. Higher rating first
// 2. Lexicographically smaller name if ratings are equal
type FoodHeap []Food

// Implementing heap.Interface for FoodHeap

func (h FoodHeap) Len() int {
	return len(h)
}

// Less defines the heap order: max-heap by rating, min-heap by name (lexicographically)
func (h FoodHeap) Less(i, j int) bool {
	if h[i].rating != h[j].rating {
		return h[i].rating > h[j].rating // Higher rating first
	}
	return h[i].name < h[j].name // Tie-break by name (alphabetical order)
}

func (h FoodHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *FoodHeap) Push(x interface{}) {
	*h = append(*h, x.(Food))
}

func (h *FoodHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[:n-1]
	return item
}

///////////////////////////////////////////////////////////////////////////////
//                               CONSTRUCTOR                                //
///////////////////////////////////////////////////////////////////////////////

// Constructor initializes the FoodRatings system with initial foods, cuisines, and ratings.
func Constructor(foods []string, cuisines []string, ratings []int) FoodRatings {
	fr := FoodRatings{
		foodToCuisine: make(map[string]string),
		foodToRating:  make(map[string]int),
		cuisineHeaps:  make(map[string]*FoodHeap),
	}

	// Populate the data structures
	for i := range foods {
		food := foods[i]
		cuisine := cuisines[i]
		rating := ratings[i]

		fr.foodToCuisine[food] = cuisine      // Map food -> cuisine
		fr.foodToRating[food] = rating        // Map food -> rating

		// Create a heap for this cuisine if it doesn't exist
		if _, exists := fr.cuisineHeaps[cuisine]; !exists {
			fr.cuisineHeaps[cuisine] = &FoodHeap{}
			heap.Init(fr.cuisineHeaps[cuisine])
		}

		// Push the food into the appropriate cuisine heap
		heap.Push(fr.cuisineHeaps[cuisine], Food{name: food, rating: rating})
	}

	return fr
}

///////////////////////////////////////////////////////////////////////////////
//                             CHANGE RATING                                //
///////////////////////////////////////////////////////////////////////////////

// ChangeRating updates the rating of a given food to a new value.
func (fr *FoodRatings) ChangeRating(food string, newRating int) {
	fr.foodToRating[food] = newRating // Update the rating map

	cuisine := fr.foodToCuisine[food] // Get the cuisine for this food

	// Push the new rating into the heap.
	// NOTE: We use lazy deletion — outdated values remain in heap and are skipped when needed.
	heap.Push(fr.cuisineHeaps[cuisine], Food{name: food, rating: newRating})
}

///////////////////////////////////////////////////////////////////////////////
//                           HIGHEST RATED FOOD                             //
///////////////////////////////////////////////////////////////////////////////

// HighestRated returns the food with the highest rating for a given cuisine.
// In case of a tie, it returns the lexicographically smallest name.
func (fr *FoodRatings) HighestRated(cuisine string) string {
	h := fr.cuisineHeaps[cuisine] // Get the heap for the cuisine

	for {
		top := (*h)[0] // Peek the top of the heap (best-rated food)

		// Check if the top element is valid (not outdated due to lazy deletion)
		if fr.foodToRating[top.name] == top.rating {
			return top.name // Valid top — return it
		}

		// Outdated entry — remove and continue checking
		heap.Pop(h)
	}
}
