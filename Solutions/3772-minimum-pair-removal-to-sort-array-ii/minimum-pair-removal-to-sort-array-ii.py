from typing import List
import heapq

class Solution:
    def minimumPairRemoval(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        prev = list(range(-1, n - 1))
        nxt = list(range(1, n + 1))
        nxt[-1] = -1

        alive = [True] * n
        heap = []

        decreaseCount = 0
        for i in range(n - 1):
            if nums[i] > nums[i + 1]:
                decreaseCount += 1
            heapq.heappush(heap, (nums[i] + nums[i + 1], i))

        ops = 0

        while decreaseCount > 0:
            s, i = heapq.heappop(heap)
            j = nxt[i]

            # Lazy deletion check
            if (
                j == -1 or
                not alive[i] or
                not alive[j] or
                nums[i] + nums[j] != s
            ):
                continue

            pi = prev[i]
            nj = nxt[j]

            # Remove old decreasing relations
            if pi != -1 and nums[pi] > nums[i]:
                decreaseCount -= 1
            if nums[i] > nums[j]:
                decreaseCount -= 1
            if nj != -1 and nums[j] > nums[nj]:
                decreaseCount -= 1

            # Merge
            nums[i] += nums[j]
            alive[j] = False
            nxt[i] = nj
            if nj != -1:
                prev[nj] = i

            # Add new decreasing relations
            if pi != -1 and nums[pi] > nums[i]:
                decreaseCount += 1
            if nj != -1 and nums[i] > nums[nj]:
                decreaseCount += 1

            # Push new adjacent pairs
            if pi != -1:
                heapq.heappush(heap, (nums[pi] + nums[i], pi))
            if nj != -1:
                heapq.heappush(heap, (nums[i] + nums[nj], i))

            ops += 1

        return ops
