module Helper

  def welcome
    print "#" * 36 + "\n" + "#       Welcome to Expensable      #" + "\n" + "#" * 36 + "\n"
    welcome_options = ["login", "create_user", "exit"]
    puts welcome_options.join(" | ")
  end

  def goodbye
    print "#" * 36 + "\n" + "#    Thanks for using Expensable   #" + "\n" + "#" * 36 + "\n"
  end

end