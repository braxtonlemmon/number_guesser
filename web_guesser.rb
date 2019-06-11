require 'sinatra'
require 'sinatra/reloader'

@@count = 5
@@number = rand(101)
cheat = ""
guess = nil
background = 'white'
message = "Guess a number between 0 and 100!"
result = ""

get '/' do
	if params['cheat'] == 'true'
		cheat = "I don't know why you want to see this... Secret number: #{@@number}"
	end

	if params['guess'] != nil
		result = ""
		guess = params["guess"].to_i
		message = check_guess(guess)
		background = set_background(message)
		@@count -= 1
		if guess == @@number || @@count == 0
			result = (guess == @@number) ? "Congratulations you won!" : "Sorry you lost..."
			result << " The game will now be reset."
			@@count = 5
			@@number = rand(101)
			cheat = ""
			params['cheat'] = false
		end	
	end
	erb :index, :locals => {:number => @@number, 
													:message => message,
													:count => @@count,
													:result => result,
													:cheat => cheat,
													:background => background
												 }
end

def check_guess(guess)
	if guess == @@number
		"You got it right!"
	elsif guess > @@number
		(guess > @@number + 5) ? "Way too high!" : "Too high!"
	elsif guess < @@number
		(guess < @@number - 5) ? "Way too low!" : "Too low!"
	else "Error!"
	end
end

def set_background(message)
	case message
	when "You got it right!" then 'green'
	when "Way too high!"     then 'red'
	when "Way too low!"      then 'red'
	when "Too high!"         then 'pink'
	when "Too low!"          then 'pink'
	else "white"
	end
end

