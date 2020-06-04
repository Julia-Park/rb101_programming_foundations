For example, write out pseudo-code (both casual and formal) that does the following:

    1. a method that returns the sum of two integers
    2. a method that takes an array of strings, and returns a string that is all those strings concatenated together
    3. a method that takes an array of integers, and returns a new array with every other element


NUMBER 1
  Casual:
    Given two integers
    Add both integers together
    Return the result

  Formal:
    START
    
    GET integer1
    GET integer2
    PRINT integer1 + integer2
    
    END

NUMBER 2
  Casual:
    Given an array of strings
    Iterate through array
    - Adding each string to a saved string (concatenation)
    After interation is finished, return saved string 

  Formal:
    START
    
    # This part might not be necessary if program has a pre-supplied array of strings
    GET sentence
    SET string_array = sentence split into array using space as delimiter

    SET iterator = 0 

    WHILE iterator < length of string_array
      SET concat_string += value of string_array at index == iterator

      SET iterator += 1

    PRINT concat_string
    
    END

NUMBER 3
  Casual:
    Given array of integers
    Iterate through array
    - Save every other value to new array
    Return new array

  Formal:
    START

    # Given array of integers
    GET integer_array

    SET iterator = 0

    WHILE iterator < length of integer_array 
      IF iterator is even
        new_array << iterator

    PRINT new_array

    END





