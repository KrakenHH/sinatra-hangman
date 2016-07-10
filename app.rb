require './hangman'
require 'sinatra'
require 'sinatra/reloader'

h = Hangman.new
@answer_array_str = h.correct_guesses.join(' ')

@guesses = h.guessed_array.join(' ')


get '/' do
  h.guess_letter_or_word(params[:guess]) 
  @answer_array_str = h.correct_guesses.join(' ')
  @guesses = h.guessed_array.join(' ')
  erb :index
end
