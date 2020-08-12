thread =  Thread.new do
            puts 'There is going to be a delay...'
            sleep 3
          end

thread.join

puts 'Type in either "hi" or "bye"!'
answer = gets.chomp.capitalize

puts %w(Hi Bye).include?(answer)
