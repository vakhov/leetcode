# @param {String} s
# @return {String}
def make_good(s)
    stack = []
    s.each_char do |char|
        if !stack.empty? && (char.ord - stack[-1].ord).abs == 32
            stack.pop
            next
        end
        stack.push(char)
    end
    stack.join('')
end

puts make_good("leEeetcode") == "leetcode"
puts make_good("abBAcC") == ""
puts make_good("s") == "s"