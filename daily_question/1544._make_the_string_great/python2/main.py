class Solution(object):
    def makeGood(self, s):
        """
        :type s: str
        :rtype: str
        """
        stack = []
        for char in s:
            if stack and abs(ord(char) - ord(stack[-1])) == 32:
                stack.pop()
            else:
                stack.append(char)
        return ''.join(stack)


if __name__ == "__main__":
    solution: Solution = Solution()

    assert solution.makeGood("leEeetcode") == "leetcode"
    assert solution.makeGood("abBAcC") == ""
    assert solution.makeGood("s") == "s"
