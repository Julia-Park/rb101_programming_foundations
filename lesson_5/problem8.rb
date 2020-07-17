hsh = { first: ['the', 'quick'],
        second: ['brown', 'fox'],
        third: ['jumped'],
        fourth: ['over', 'the', 'lazy', 'dog'] }

# ouput all vowels from the strings using Hash#each

hsh.each do |key, words|
  words.each do |word|
    word.chars.each do |c|
      puts c if 'aeiou'.include?(c)
    end
  end
end
