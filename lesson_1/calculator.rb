# Ruby Calculator Assignment
# Integer Math Only

#Methods to validate user input
def valid_int?(num)
  !/^\d+$/.match(num).nil?
end
  
def valid_operator?(num)
  !/^[1-4]$/.match(num).nil?
end

#Methods to get user input
def get_num
  puts "==> Enter an Integer"
  num=gets.chomp
  while !valid_int?(num)
    puts"==> Try again, Integer input please"
    num=gets.chomp
  end
  num.to_i
end

def get_operator
  puts "==> Pick an Operator by Number"
  puts "==> 1) Addition (+), 2) Subtraction (-), 3) Multiplication (x), 4) Division (/)"
  operator=gets.chomp
  while !valid_operator?(operator)
    puts"==> Try again, Input 1,2,3 or 4"
    puts "==> 1) Addition (+), 2) Subtraction (-), 3) Multiplication (x), 4) Division (/)"
    operator=gets.chomp
  end
  operator.to_i
end

# Main Calculator Program
puts "Try the amazing integer calculator!!"
num1=get_num
operator=get_operator
num2=get_num

#Array of operators for display only
operators=["+","-","x","/"]

if operator == 1
  result = num1 + num2
elsif operator == 2
  result = num1 - num2
elsif operator == 3
  result = num1 * num2
elsif operator == 4
  if num2 == 0
    result = "ERROR: Can't divide by 0"
  else
    result = num1 / num2
  end
end

puts "#{num1} #{operators[operator-1]} #{num2} = #{result}"