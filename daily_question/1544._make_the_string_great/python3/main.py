class Solution:
    def makeGood(self, s: str) -> str:
        stack: list = []
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
