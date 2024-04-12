/**
 * @param {string} s
 * @return {string}
 */
var makeGood = function (s) {
    stack = [];
    for (let char of s) {
        if (stack.length > 0 && Math.abs(char.charCodeAt(0) - stack[stack.length - 1].charCodeAt(0)) === 32) {
            stack.pop();
            continue;
        }
        stack.push(char);
    }
    return stack.join('');
};

console.log(makeGood("leEeetcode") === "leetcode");
console.log(makeGood("abBAcC") === "");
console.log(makeGood("s") === "s");