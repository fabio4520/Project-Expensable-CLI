module Helper

  def welcome
    print "#" * 36 + "\n" + "#       Welcome to Expensable      #" + "\n" + "#" * 36 + "\n"
  end

  def options_menu
    welcome_options = ["login", "create_user", "exit"]
    puts welcome_options.join(" | ")
  end

  def goodbye
    print "#" * 36 + "\n" + "#    Thanks for using Expensable   #" + "\n" + "#" * 36 + "\n"
  end

  def create_user_form
    validation = false
    unless validation
      print "Email: "
      email = gets.chomp
      puts "Invalid format" if email.empty? || !email.match?(/\w*@\w*.[a-z]{2,3}/)
      return validation if email.empty? || !email.match?(/\w*@\w*.[a-z]{2,3}/)

      print "Password: "
      password = gets.chomp
      puts "Minimun 6 characters" if password.empty? || password.length < 6
      return validation if password.empty? || password.length < 6

      print "First name: "
      first_name = gets.chomp
      print "Last name: "
      last_name = gets.chomp
      print "Phone: "
      phone = gets.chomp
      puts "Required format: +51 111222333 or 111222333" unless phone.match?(/^\d{9}/)
      return validation unless phone.match?(/^\d{9}/)
      validation = true
    end
    full_name = [first_name, last_name].join(" ")
    puts "Welcome to Expensable #{full_name}"

    return [{
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      phone: phone
    }, validation]
  end 

end