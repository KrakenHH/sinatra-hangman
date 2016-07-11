require './hangman'
require 'sinatra'
require 'sinatra/reloader'
require 'shotgun'

h = Hangman.new
@answer_array_str = h.correct_guesses.join(' ')
@guesses = h.guessed_array.join(' ')


get '/' do
  erb :welcome
end
