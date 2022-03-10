module Helper
# require_relative 'services/sessions.rb'

  def welcome
    print "#" * 36 + "\n" + "#       Welcome to Expensable      #" + "\n" + "#" * 36 + "\n"
    welcome_options = ["login", "create_user", "exit"]
    puts welcome_options.join(" | ")
  end

  def goodbye
    print "#" * 36 + "\n" + "#    Thanks for using Expensable   #" + "\n" + "#" * 36 + "\n"
  end

  def login
    credentials = login_form
    @user = Services::Sessions.login(credentials)
    puts "Welcome back Test User"
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
    email = get_string("Email")
    password = get_string("Password")

    {email: email, password: password}
  end

end