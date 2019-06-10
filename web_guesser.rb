require 'sinatra'
require 'sinatra/reloader'

number = rand(101)

def check_guess(guess, number)
	guess = guess.to_i
	if guess == number
		"You got it right!"
	elsif guess - number > 5
		"Way too high!"
	elsif guess - number < -5
		"Way too low!"
	elsif guess > number
		"Too high!"
	elsif guess < number
		"Too low!"
	end
end

get '/' do
	guess = params["guess"]
	message = check_guess(guess, number)
	erb :index, :locals => {:number => number, :message => message }
end