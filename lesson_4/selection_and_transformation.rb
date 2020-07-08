# input hash
# return hash with all key value pairs where the value is 'Fruit'

def select_fruit(all_produce)
  keys = all_produce.keys
  index = 0
  fruit_hash = {}

  until index == all_produce.size
    key = keys[index]

    if all_produce[key] == 'Fruit'
      fruit_hash[key] = 'Fruit'
    end

    index += 1
  end
  
  fruit_hash
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
