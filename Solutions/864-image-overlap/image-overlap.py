class Solution:
    def largestOverlap(self, img1: List[List[int]], img2: List[List[int]]) -> int:
        n = len(img1)
        ans = 0

        # Try every possible row and column shift
        for dr in range(-n + 1, n):
            for dc in range(-n + 1, n):
                overlap = 0

                # Check how many 1s overlap after this shift
                for r in range(n):
                    for c in range(n):
                        nr = r + dr
                        nc = c + dc

                        # Ignore cells that move outside the matrix
                        if 0 <= nr < n and 0 <= nc < n:
                            if img1[r][c] == 1 and img2[nr][nc] == 1:
                                overlap += 1

                # Keep the maximum overlap found so far
                ans = max(ans, overlap)

        return ans
