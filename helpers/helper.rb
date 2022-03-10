module Helper
# require_relative 'services/sessions.rb'

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


  def login
    credentials, validation = login_form
    @user = Services::Sessions.login(credentials)
    # puts @user[] if @user.length == 1
    puts "Welcome back #{@user[:first_name]} #{@user[:last_name]}"
  end

  def get_string(label, required: false)
    input = ""

    loop do
      print "#{label}: "
      input = gets.chomp
      break unless input.empty? && required

      puts "Can't be blank"
    end

    input
  end

  def login_form
    email = get_string("Email", required: true)
    password = get_string("Password", required: true)

    {email: email, password: password}
  end

  def create_user_form
 
    print "Email: "
    email = gets.chomp
    while email.empty? || !email.match?(/\w*@\w*.[a-z]{2,3}/)
      puts "Invalid format"
      print "Email: "
    email = gets.chomp
    end

    print "Password: "
    password = gets.chomp
    while password.empty? || password.length < 6
      puts "Minimun 6 characters"
      print "Password: "
      password = gets.chomp
    end

    print "First name: "
    first_name = gets.chomp
    print "Last name: "
    last_name = gets.chomp
    print "Phone: "
    phone = gets.chomp
    until phone.match?(/^\d{9}/)
      puts "Required format: +51 111222333 or 111222333"
      print "Phone: "
      phone = gets.chomp
    end

    full_name = [first_name, last_name].join(" ")
    puts "Welcome to Expensable #{full_name}"

    {
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      phone: phone
    }
  end 

  def categories_menu
    a = ["create", "show ID", "update ID", "delete ID"]
    b = ["add-to ID", "toggle", "next", "prev", "logout"]
    action= ""
    id = nil
    options = (a.map{|string| string.delete(" ID")} + b.map{|string| string.delete(" ID")})

    until options.include?(action)
      puts [a.join(" | ") , b.join(" | ")].join("\n")
      print "> "
      action, id = gets.chomp.split
    end
    return action, id
  end

end