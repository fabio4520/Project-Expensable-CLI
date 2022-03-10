# Start here. Happy coding!
require 'terminal-table'
require 'date'
require_relative 'helpers/helper.rb'
require_relative 'services/sessions.rb'
require_relative 'services/categories.rb'

class Expensable
  include Helper

  def initialize
    @user = nil
    @category = []
    @trash = false

  end

  def start
    welcome
    
    option = ""
    # option = gets.chomp
    until option == "exit"
      options_menu
      print "> "
      option = gets.chomp
      begin 
        case option
        when "login"
          login
        when "create_user"
          puts create_user
        when "exit"
          goodbye
        else
          puts "Invalid option"
        end
      rescue HTTParty::ResponseError => error
        parsed_error = JSON.parse(error.message, symbolize_names: true)
        puts parsed_error[:errors]
      end
    end
  end

  private

  def login
    credentials, validation = login_form
    @user = Services::Sessions.login(credentials)
    puts "Welcome back #{@user[:first_name]} #{@user[:last_name]}"
    categories_page
  end

  def create_user
    credentials= create_user_form
    @user = Services::Sessions.signup(credentials)
    categories_page
  end

  def categories_page
    @category = Services::Categories.index(@user[:token])
    action, id = ""
    until action == "logout"
      puts categories_table(@category)
      action, id = categories_menu
      case action
      when "create" then puts "create"
      when "show" then puts "show"
      when "update" then puts "update"
      when "delete" then puts "delete"
      when "add-to" then puts "add-to"
      when "toggle" then puts "toggle"
      when "next" then puts "next"
      when "prev" then puts "prev"
      when "logout" then puts "logout!"
      end
    end
  end

  def categories_table(category, initial_date = Date.new(2021, 12, 1), transaction_type = "expense")
    # initial_date = Date.new(2021, 9, 1) # escogido arbitrariamente
    initial_month = initial_date.month
    categories_show = []
    for arr in category
      hash = {
        id: arr[:id],
        name: arr[:name],
        transaction_type: arr[:transaction_type],
        transactions: arr[:transactions].select do |trans|
          trans[:date].split("-")[1].to_i == initial_month
        end
      }
      categories_show << hash if arr[:transaction_type] == transaction_type
    end
    categories_show.compact!
    table = Terminal::Table.new
    table.title = "#{transaction_type.capitalize}s\n#{initial_date.strftime('%B %Y')}"
    table.headings = ['ID', 'Category' , 'Total']
    hola = []
    categories_show.each do |c|
      a = c[:transactions].map { |t| t[:amount] }.sum
      hola << [c[:id], c[:name], a] unless a == 0
    end
    table.rows = hola
    table
  end

end

expensable = Expensable.new
expensable.start
# case_options
