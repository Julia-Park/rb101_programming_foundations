# Question 1
greeting returns nil.  Variables initialized within an if block that does not run, the variable is initialized to nil.

# Question 2
{a: 'hi there'}

# Question 3
A)  one is: one
    two is: two
    three is: three
  While the variables within the method have the same name, they are different from the variables initialized outside of the method.  When the reassignment happens within the method, it does not affect the variables outside of the method. Reassignment happens to the in-method variables to point to the same memory block as the other outside-of-method variables, but the contents of the memory itself does not change (reassignment is not mutating); therefore, the outside variables that point to the memory blocks recall the same values as before the method. 

B)  one is: one
    two is: two
    three is: three
  Reassignment inside the method does not affect variables outside of the method.

C)  one is: two
    two is: three
    three is: one
  String#gsub! is mutating.

