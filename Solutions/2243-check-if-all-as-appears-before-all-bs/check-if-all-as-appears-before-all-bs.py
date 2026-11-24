class Solution:
    def checkString(self, s):
        b_seen = False
        for ch in s:
            if ((ch == 'a') and b_seen): return False
            elif (ch == 'b'): b_seen = True
        return True
