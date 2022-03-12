require 'terminal-table'
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

  def print_table(title, headings, rows)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    table.rows = rows
    puts table
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
    action, id = validate_menu(a,b)
  end

  def create_category_menu
    name, transaction_type = "", ""
    while name.empty?
      print "Name: "
      name = gets.chomp
      puts "Cannot be blank" if name.empty?
    end
    options = ["income", "expense"]
    until options.include?(transaction_type.downcase)
      print "Transaction type: "
      transaction_type = gets.chomp.downcase
      puts "Only income or expense" unless options.include?(transaction_type.downcase)
    end
    return name, transaction_type
  end

  def update_category_menu
    create_category_menu
  end

  def show_menu
    a = ["add", "update ID", "delete ID"]
    b = ["next", "prev", "back"]
    action, id = validate_menu(a,b)
  end

  def validate_menu(a,b)
    action= ""
    id = nil
    options = (a.map{|string| string.delete(" ID")} + b.map{|string| string.delete(" ID")})

    until options.include?(action)
      puts [a.join(" | ") , b.join(" | ")].join("\n")
      print "> "
      action, id = gets.chomp.split
    end
    return action, id.to_i
  end

  def add_transaction_menu
    amount, date = 0, ""
    until amount.positive?
      print "Amount: "
      amount = gets.chomp.to_i
      puts "Cannot be zero" unless amount.positive?
    end
    until date.match?(/\d{4}-\d{2}-\d{2}/)
      print "Date: "
      date = gets.chomp
      puts "Required format: YYYY-MM-DD" unless date.match?(/\d{4}-\d{2}-\d{2}/)
    end
    print "Notes: "
    notes = gets.chomp
    return amount, date, notes
  end

  def update_transaction_menu
    add_transaction_menu
  end

end