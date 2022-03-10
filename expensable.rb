# Start here. Happy coding!
require_relative 'helpers/helper.rb'

class Expensable
  include Helper
  def start
    welcome
    option = ""
    # option = gets.chomp
    until option == "exit"
      print "> "
      option = gets.chomp
      case option
      when "login"
        puts "login"
      when "create_user"
        puts "create_user"
      when "exit"
        goodbye
      else
        puts "Invalid option"
      end
    end
  end

end

expensable = Expensable.new
expensable.start
# case_options
