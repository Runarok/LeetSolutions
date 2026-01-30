from dataclasses import dataclass
from collections import defaultdict
from functools import lru_cache
import heapq
from typing import List
from math import inf


# Trie node used to store valid substrings from `original`
@dataclass
class TrieNode:
    children: dict        # maps character -> TrieNode
    flag: bool            # True if this node ends a valid word


class Solution:
    def minimumCost(
        self,
        source: str,
        target: str,
        original: List[str],
        changed: List[str],
        cost: List[int]
    ) -> int:

        # -------------------------------------------------------
        # STEP 1: Assign a unique integer ID to every string
        # -------------------------------------------------------
        # We need numeric node IDs so we can run Dijkstra efficiently
        unique_id = defaultdict(lambda: None)
        uid = 0

        # Include:
        # - all original strings
        # - all changed strings
        # - all single characters 'a' to 'z'
        for array in [original, changed, [chr(c) for c in range(97, 123)]]:
            for string in set(array):
                unique_id[string] = uid
                uid += 1

        # -------------------------------------------------------
        # STEP 2: Build a directed weighted graph of transformations
        # -------------------------------------------------------
        # neighbours[u] = list of (v, cost) transformations
        neighbours = defaultdict(list)

        for src, dest, change_cost in zip(original, changed, cost):
            neighbours[unique_id[src]].append(
                (unique_id[dest], change_cost)
            )

        # -------------------------------------------------------
        # STEP 3: Shortest path between two strings using Dijkstra
        # -------------------------------------------------------
        # Memoized because the same transformations are queried many times
        @lru_cache(None)
        def calculate_distance(i: int, j: int) -> int:
            # If either string doesn't exist, transformation is impossible
            if i is None or j is None:
                return inf

            # Min-heap for Dijkstra
            heap = [(0, i)]
            distance = defaultdict(lambda: inf)
            distance[i] = 0

            while heap:
                current_distance, node = heapq.heappop(heap)

                # Early stop once target is reached
                if node == j:
                    break

                # Ignore outdated heap entries
                if current_distance > distance[node]:
                    continue

                # Relax outgoing edges
                for nxt, change_cost in neighbours[node]:
                    new_dist = current_distance + change_cost
                    if distance[nxt] > new_dist:
                        distance[nxt] = new_dist
                        heapq.heappush(heap, (new_dist, nxt))

            return distance[j]

        # -------------------------------------------------------
        # STEP 4: Build a Trie of valid source substrings
        # -------------------------------------------------------
        root = TrieNode({}, False)

        def insert_to_trie(string: str) -> None:
            node = root
            for char in string:
                if char not in node.children:
                    node.children[char] = TrieNode({}, False)
                node = node.children[char]
            node.flag = True  # mark end of valid word

        # Insert all transformable strings
        for src in original:
            insert_to_trie(src)

        # Insert single characters (always allowed)
        for char in range(97, 123):
            insert_to_trie(chr(char))

        # -------------------------------------------------------
        # STEP 5: DP over source string using Trie + Dijkstra
        # -------------------------------------------------------
        # dp(i) = minimum cost to transform source[i:]
        @lru_cache(None)
        def dp(i: int) -> int:
            # Base case: finished processing source
            if i == len(source):
                return 0

            node = root
            ans = inf
            j = i

            # Walk the trie starting from position i
            while j < len(source) and source[j] in node.children:
                node = node.children[source[j]]

                # If we found a valid substring source[i:j+1]
                if node.flag:
                    src_sub = source[i:j + 1]
                    tgt_sub = target[i:j + 1]

                    # Cost = transform substring + cost of rest
                    ans = min(
                        ans,
                        dp(j + 1)
                        + calculate_distance(
                            unique_id[src_sub],
                            unique_id[tgt_sub]
                        )
                    )
                j += 1

            return ans

        # -------------------------------------------------------
        # STEP 6: Final answer
        # -------------------------------------------------------
        result = dp(0)
        return result if result != inf else -1
