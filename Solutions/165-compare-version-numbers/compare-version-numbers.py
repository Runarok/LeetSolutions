class Solution:
    def compareVersion(self, version1: str, version2: str) -> int:
        # Step 1: Split both version strings into list of revision strings
        v1_parts = version1.split('.')
        v2_parts = version2.split('.')

        # Step 2: Convert all revision strings to integers to ignore leading zeros
        v1_nums = list(map(int, v1_parts))
        v2_nums = list(map(int, v2_parts))

        # Step 3: Determine the maximum length of both version lists
        max_length = max(len(v1_nums), len(v2_nums))

        # Step 4: Pad the shorter list with zeros (if necessary)
        # This ensures both lists have the same number of revisions
        while len(v1_nums) < max_length:
            v1_nums.append(0)
        while len(v2_nums) < max_length:
            v2_nums.append(0)

        # Step 5: Compare each revision one by one
        for i in range(max_length):
            if v1_nums[i] < v2_nums[i]:
                return -1  # version1 is less than version2
            elif v1_nums[i] > v2_nums[i]:
                return 1   # version1 is greater than version2

        # Step 6: All revisions are equal
        return 0
