# return array containing colours of fruits, sizes of vegetables
# sizes should be uppercase, colours should be capitalized
# expected return: [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

array =
  hsh.map do |fruit, details|
    case details[:type]
    when 'fruit'
      details[:colors].map { |color| color.capitalize }
    else
      details[:size].upcase
    end
  end

p array
