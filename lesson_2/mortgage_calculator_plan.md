Problem:
Inputs: Loan amount (principle), Annual Percentage Rate (APR), loan duration (duration_yrs)
Calculate: Monthly interest rate (monthly_interest), loan duration in months (duration_months), monthly payment (monthly_payment)
How: m = p * (j / (1 - (1 + j)**(-n)))
m = monthly payment
p = loan amount
j = monthly interest rate
n = loan duration in months

Examples:
mortgage(1000,1,12) = monthly_payment = 88.85
                       duration_months = 12

Data Structure:
Loan Amount - Principle - Float
  user input method to validate
APR - principle, divide by 12 for monthly interest rate; input as percent - Float
  user input method to validate
Loan duration - input in years, output in months - Integer
  user input method to validate > validation should be for integer
Monthly payment - Float, rounded to 2 decimal places
  use formula in method > input above three, return monthly payment

Algorithm:

<<-NOT
Greeting -> "What is loan principle?"
              |
              Validate -> "What is APR?"
                          |
                          Validate -> "What is loan duration?"
                                        |
                                        Validate -> Calculate monthly payments -> return monthly payments
NOT
