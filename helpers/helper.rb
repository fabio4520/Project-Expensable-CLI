module Helper

  def welcome
    print "#" * 36 + "\n" + "#       Welcome to Expensable      #" + "\n" + "#" * 36 + "\n"
    welcome_options = ["login", "create_user", "exit"]
    puts welcome_options.join(" | ")
  end

  def goodbye
    print "#" * 36 + "\n" + "#    Thanks for using Expensable   #" + "\n" + "#" * 36 + "\n"
  end

  def create_user_form
    print "Email: "
    email = gets.chomp
    print "Password: "
    password = gets.chomp
    print "First name: "
    first_name = gets.chomp
    print "Last name: "
    last_name = gets.chomp
    print "Phone: "
    phone = gets.chomp
    full_name = [first_name, last_name].join(" ")
    print "Welcome to Expensable #{full_name}"
    {
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      phone: phone
    }
  end

end