require 'sinatra'
require 'sinatra/reloader'

num = rand(101)
get '/' do
	"The SECRET NUMBER ist #{num}"
end