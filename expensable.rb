# Start here. Happy coding!
require 'terminal-table'
require 'date'
require_relative 'helpers/helper.rb'
require_relative 'services/sessions.rb'
require_relative 'services/categories.rb'
require_relative 'services/transactions.rb'

class Expensable
  include Helper

  def initialize
    @user = nil
    @category = [] # me trae todas las categories
    @category_selected = {}
    @trash = false
    @initial_date = Date.new(2021, 12, 1)
    @transaction_type = "expense"
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
      categories_table(@category)
      action, id = categories_menu
      case action
      when "create" then create_category
      when "show" then show_category(id)
      when "update" then update_category(id)
      when "delete" then delete_category(id)
      when "add-to" then puts "add-to"
      when "toggle" then puts "toggle"
      when "next" then puts "next"
      when "prev" then puts "prev"
      when "logout" then puts "logout!"
      end
    end
  end

  def show_category(id)
    @category_selected = Services::Categories.show(@user[:token], id)

    action = ""
    until action == "back"
      
      transactions = @category_selected[:transactions].select { |trans| trans[:date].split("-")[1].to_i == @initial_date.month }
      @category_selected[:transactions] = transactions
      
      title = "#{@category_selected[:name]}\n#{@initial_date.strftime('%B %Y')}"
      headings = ["ID", "Date", "Amount", "Notes"]
      rows = @category_selected[:transactions].map do |element|
        date = element[:date].split("-").map { |str| str.to_i }
        [element[:id], Date.new(date[0], date[1], date[2]).strftime('%a, %b %d'), element[:amount], element[:notes]]
      end


      print_table(title, headings, rows)
      action, id_show = show_menu
      case action
      when "add" then add_transaction(id)
      when "update" then update_transaction(id, id_show)
      when "delete" then delete_transaction(id, id_show)
      when "next" then puts ""
      when "prev" then puts ""
      when "back" then puts "Bye!"
      end
    end
  end

  def update_transaction(id, id_show)
    amount, date, notes = update_transaction_menu
    transaction_to_update_index = @category_selected[:transactions].find_index { |cat| cat[:id] == id_show}
    transaction_updated = Services::Transactions.update(@user[:token], id, id_show,  {amount: amount, notes: notes, date: date})
    @category_selected[:transactions][transaction_to_update_index] = transaction_updated
  end

  def delete_transaction(id, id_show)
    transaction_deleted_index = @category_selected[:transactions].find_index { |trans| trans[:id] == id_show}
    Services::Transactions.destroy(@user[:token], id, id_show)
    @category_selected[:transactions].delete_at(transaction_deleted_index)
  end

  def add_transaction(id)
    amount, date, notes = add_transaction_menu
    transaction_created = Services::Transactions.create(@user[:token], {amount: amount, notes: notes, date: date}, id)
    @category_selected[:transactions] << transaction_created
  end

  def update_category(id)
    name, transaction_type = update_category_menu
    category_to_update_index = @category.find_index { |cat| cat[:id] == id}
    category_updated = Services::Categories.update(@user[:token], id, {name: name, transaction_type: transaction_type})
    @category[category_to_update_index] = category_updated    
  end

  def delete_category(id)
    category_deleted_index = @category.find_index { |cat| cat[:id] == id}
    Services::Categories.destroy(@user[:token], id)
    @category.delete_at(category_deleted_index)
  end

  def create_category
    name, transaction_type = create_category_menu
    new_category = Services::Categories.create(@user[:token], {name: name, transaction_type: transaction_type})
    @category << new_category
  end

  def categories_table(category, initial_date = @initial_date, transaction_type = @transaction_type)
    # initial_date = Date.new(2021, 12, 1) # escogido arbitrariamente
    initial_month = initial_date.month
    found_category = find_categories(category, initial_month, transaction_type)

    title = "#{transaction_type.capitalize}s\n#{initial_date.strftime('%B %Y')}"
    headings = ['ID', 'Category' , 'Total']
    rows = found_category.map do |c|
      [c[:id], c[:name], c[:transactions].map { |t| t[:amount] }.sum]
    end
    print_table(title, headings, rows)
  end

  def find_categories(category, initial_month, transaction_type)
    found_categories = []
    for arr in category
      hash = {
        id: arr[:id],
        name: arr[:name],
        transaction_type: arr[:transaction_type],
        transactions: arr[:transactions].select do |trans|
          trans[:date].split("-")[1].to_i == initial_month
        end
      }
      found_categories << hash if arr[:transaction_type] == transaction_type
    end
    found_categories.compact!
    found_categories
  end

end

expensable = Expensable.new
expensable.start
# case_options
