require './hangman'
require 'sinatra'
require 'sinatra/reloader'
require 'shotgun'

enable :sessions

h = Hangman.new


get '/' do
  session[:guesses_left] = 15
  session[:secret_word] = random_word_giver
  session[:hangman_layout] = Array.new(session[:secret_word].size) { '_' }
  session[:guesses] = []
  @hangman_layout = session[:hangman_layout]
  erb :welcome
end

post '/guess_response' do
  session[:guesses_left] -= 1
  @guesses_left = session[:guesses_left]
  session[:guesses] << params[:guess]
  @guesses = session[:guesses]
  @guess = params[:guess]
  @hangman_layout = session[:hangman_layout]
  erb :response
end





helpers do

  def random_word_giver
    myFile = File.open("dict.txt", "r")
    dict_string = myFile.read
    myFile.close
    dict_array = dict_string.split("\n")

    rand_word = ""
    loop do
      rand_word = dict_array.sample
      break if rand_word.length >= 5 && rand_word.length <= 12
    end
    rand_word
  end



end