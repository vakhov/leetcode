<?php
class Solution {

    /**
     * @param String $s
     * @return String
     */
    function makeGood($s) {
        $stack = [];
        for ($i = 0; $i < strlen($s); $i++) {
            $char = $s[$i];
            if (!empty($stack) && abs(ord($char) - ord(end($stack))) == 32) {
                array_pop($stack);
                continue;
            }
            array_push($stack, $char);
        }

        return implode("", $stack);
    }
}

$solution = new Solution();
echo (assert($solution->makeGood("leEeetcode") === "leetcode") ? 'true' : 'false'). "\n";
echo (assert($solution->makeGood("abBAcC") === "") ? 'true' : 'false'). "\n";
echo (assert($solution->makeGood("s") === "s") ? 'true' : 'false'). "\n";
?>