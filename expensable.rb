# Start here. Happy coding!
require_relative 'helpers/helper.rb'
require_relative 'services/sessions.rb'

class Expensable
  include Helper

  def initialize
    @user = nil
    @notes = []
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

  def create_user
    credentials= create_user_form
    @user = Services::Sessions.signup(credentials)
  end

  def notes_page
    @notes = Services::Categories.index(@user[:token])
  end

end

expensable = Expensable.new
expensable.start
# case_options
