import math
class Solution:
    def repeatedStringMatch(self, A: str, B: str) -> int:
        lA,lB=len(A),len(B)
        count = math.ceil(lB/lA)
        s=count*A
        if B in s:
            return s
        else:
            return -1
if __name__ == '__main__':
    print(Solution().repeatedStringMatch("abcd","cdabcdab"))