# Start here. Happy coding!
require_relative 'helpers/helper.rb'
require_relative 'services/sessions.rb'

class Expensable
  include Helper

  def initialize
    @user = nil
    @notes = []
  end

  def start
    welcome
    option = ""
    # option = gets.chomp
    until option == "exit"
      print "> "
      option = gets.chomp
      case option
      when "login"
        puts "login"
      when "create_user"
        puts create_user
      when "exit"
        goodbye
      else
        puts "Invalid option"
      end
    end
  end

  private

  def create_user
    credentials = create_user_form
    @user = Services::Sessions.signup(credentials)
    p @user
  end


end

expensable = Expensable.new
expensable.start
# case_options
