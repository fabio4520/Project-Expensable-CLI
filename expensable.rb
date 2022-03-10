# Start here. Happy coding!
def welcome
  print "#" * 36 + "\n" + "#       Welcome to Expensable      #" + "\n" + "#" * 36 + "\n"
  welcome_options = ["login", "create_user", "exit"]
  puts welcome_options.join(" | ")
end

def case_options
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
def goodbye
  print "#" * 36 + "\n" + "#    Thanks for using Expensable   #" + "\n" + "#" * 36 + "\n"
end

welcome
case_options