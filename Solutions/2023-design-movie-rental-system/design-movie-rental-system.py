# Your MovieRentingSystem object will be instantiated and called as such:
# obj = MovieRentingSystem(n, entries)
# param_1 = obj.search(movie)
# obj.rent(shop,movie)
# obj.drop(shop,movie)
# param_4 = obj.report()

from sortedcontainers import SortedList
from collections import defaultdict
from typing import List

class MovieRentingSystem:

    def __init__(self, n: int, entries: List[List[int]]):
        # Map from (shop, movie) to price
        self.price_map = {}

        # Map from movie -> SortedList of (price, shop)
        # This keeps track of unrented copies
        self.movie_available = defaultdict(SortedList)

        # SortedList of (price, shop, movie)
        # This keeps track of rented movies for report()
        self.rented = SortedList()

        for shop, movie, price in entries:
            self.price_map[(shop, movie)] = price
            # Each movie has a sorted list of (price, shop)
            self.movie_available[movie].add((price, shop))

    def search(self, movie: int) -> List[int]:
        """
        Find up to 5 unrented copies of a movie,
        sorted by price, then by shop ID.
        """
        available = self.movie_available[movie]
        return [shop for price, shop in available[:5]]

    def rent(self, shop: int, movie: int) -> None:
        """
        Rent a movie from a shop:
        - Remove from available list.
        - Add to rented list.
        """
        price = self.price_map[(shop, movie)]
        # Remove from available list
        self.movie_available[movie].remove((price, shop))
        # Add to rented list
        self.rented.add((price, shop, movie))

    def drop(self, shop: int, movie: int) -> None:
        """
        Drop off a previously rented movie:
        - Remove from rented list.
        - Add back to available list.
        """
        price = self.price_map[(shop, movie)]
        # Remove from rented list
        self.rented.remove((price, shop, movie))
        # Add back to available list
        self.movie_available[movie].add((price, shop))

    def report(self) -> List[List[int]]:
        """
        Report the cheapest 5 currently rented movies,
        sorted by price, then shop ID, then movie ID.
        """
        return [[shop, movie] for price, shop, movie in self.rented[:5]]
