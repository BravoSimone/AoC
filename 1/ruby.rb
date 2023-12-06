number_dictionary = {
  'one1one' => /one/,
  'two2two' => /two/,
  'three3three' => /three/,
  'four4four' => /four/,
  'five5five' => /five/,
  'six6six' => /six/,
  'seven7seven' => /seven/,
  'eight8eight' => /eight/,
  'nine9nine' => /nine/
}

puts File.read('input.txt')
         .tap { |file| number_dictionary.each { |sub, regex| file.gsub!(regex, sub) } }
         .split("\n")
         .map { |row| row.scan(/\d/) }
         .map { |numbers| (numbers.first + numbers.last).to_i }
         .sum
