require "sqlite3"
require "pry"

$db = SQLite3::Database.new "test.db"

class Model 

  def self.filter(category, year_begin = 2013, year_end = 2013, arg = "N")	
 		if arg.upcase == "Y" || arg.upcase == "YD"
 			return $db.execute("SELECT YEAR, #{category} from red_sox WHERE YEAR >= #{year_begin} AND YEAR <= #{year_end} ORDER BY #{category} DESC;")
 		end
 		if arg.upcase == "YA"
 			return $db.execute("SELECT YEAR, #{category} from red_sox WHERE YEAR >= #{year_begin} AND YEAR <= #{year_end} ORDER BY #{category} ASC;")
 		end
 		if arg != "Y"
  		return $db.execute("SELECT YEAR, #{category} from red_sox WHERE YEAR >= #{year_begin} AND YEAR <= #{year_end};")
 		end
 	end

end

class Controller

	def initialize
		@view = View.new
		self.render
	end

	def render
		counter = 0
		@view.welcome
		loop do 
			@view.reprompt if counter >= 1
			hold = @view.user_input 
			break if hold == "EXIT"	
			if !hold[0].include?("Not a valid")
				sql_input = Model.filter(hold[0], hold[1],
					                       hold[2], hold[3])
				@view.format(sql_input, hold[0])
			end
			counter += 1
		end
	end

end

class View

	def initialize
		@categories = ["W", "L", "WLPCNT", "PYTHWL",
									 "FINISH", "GB", "PLAYOFFS", "R", "RA", "BATAGE", "PAAGE",
									 "NUMBAT", "P", "TOPPLAYER", "MANAGER"]
		@descriptions = ["(Wins)", "(Losses)", "(WL Percentage)","(Pythagorean WP)",
		                 "(Finish)", "(Games Behind AL East Leader)", "(Playoff Report)",
		                 "(Runs)", "(Runs Allowed)", "(Position Player Age)", "(Pitcher Average Age)",
		                 "(Number of Players Used In Games)", "(Number of Pitchers Used in Games)", "(Top Player by WAR)", "(Manager)"]
		@set_default = 2013
	end

	def welcome
		system('clear')
		puts "Welcome to the Boston Red Sox Terminal App!"
		puts "All data is courtesy of Baseball Reference."
		puts "Type exit to exit at any time."
		puts "Choose a topic to display from the following options: "
		@categories.each_with_index do |category, index|
			puts "- #{category} #{@descriptions[index]}"
		end		
	end 

	def reprompt
		puts "Press enter to continue"
		continue = gets.chomp
		system('clear') 
		puts "Choose a topic to display from the following options: "
		@categories.each_with_index do |category, index|
			puts "- #{category} #{@descriptions[index]}"
		end		
	end

	def user_input
		category = gets.chomp
		entry_holder = [category, @set_default, @set_default, "N"]
		if category.upcase == "EXIT"
			puts "Thanks for using the app and go Sox!"
			return "EXIT"
		end
		if !@categories.include?(category) 
			entry_holder[0] = "Not a valid"
			puts "Not a valid entry. Press any key to continue."
			return entry_holder
		end
		puts "Please enter a date range below (1901 to 2013 inclusive)."
		puts "Please enter a starting year."
		start_year = gets.chomp.to_i
		puts "Please enter an ending year."
		end_year = gets.chomp.to_i
		if start_year <= 2013 && start_year >=1901 && end_year <= 2013 && end_year >=1901 
			 entry_holder[1] = start_year
			 entry_holder[2] = end_year
		end
		puts "Type Y to turn on sort mode"
		 optional = gets.chomp 
		 if optional.upcase == "Y"
		   entry_holder[3] = "Y"
		   puts "Type A for ascending and D for descending (default is descending)."
		   up_down = gets.chomp
		   if up_down.upcase == "A" || up_down.upcase == "D"
		     entry_holder[3] << up_down
		   end 
		 else 
		   entry_holder[3] = "N"
		 end
		 return entry_holder 
	end

	def format(sql_input, category)
		puts "YEAR                        #{category}"
		puts "***************************************"
		sql_input.each do |pair|
			puts "#{pair[0]}                   #{pair[1]}"
		end
	end

end

controller = Controller.new





