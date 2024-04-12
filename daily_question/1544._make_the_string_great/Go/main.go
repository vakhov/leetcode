package main

import "fmt"

func makeGood(s string) string {
	stack := make([]rune, 0)
	for _, char := range s {
		if len(stack) > 0 && abs(int(char)-int(stack[len(stack)-1])) == 32 {
			stack = stack[:len(stack)-1]
			continue
		}
		stack = append(stack, char)
	}

	return string(stack)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}

	return x
}

func main() {
	s := "leEeetcode"
	result := makeGood(s)
	fmt.Println(result == "leetcode")

	s = "abBAcC"
	result = makeGood(s)
	fmt.Println(result == "")

	s = "s"
	result = makeGood(s)
	fmt.Println(result == "s")
}
