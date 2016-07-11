require './hangman'
require 'sinatra'
require 'sinatra/reloader'
require 'shotgun'

enable :sessions


get '/' do
  session[:victory_condition] = false
  session[:guesses_left] = 15
  session[:secret_word_array] = random_word_giver.split("")
  session[:hangman_layout] = Array.new(session[:secret_word_array].size) { '_' }
  session[:guesses] = []
  @hangman_layout = session[:hangman_layout]
  @secret_word = session[:secret_word_array]
  erb :welcome
end

post '/guess_response' do
  session[:guesses_left] -= 1
  @guesses_left = session[:guesses_left]
  session[:guesses] << params[:guess]
  @guesses = session[:guesses]
  @guess = params[:guess]
  compare_guess(@guess)
  @hangman_layout = session[:hangman_layout]
  redirect to '/win' if session[:victory_condition]
  redirect to '/lose' if session[:guesses_left] == 0
  erb :response
end

get '/win' do
  "You win!!! The word was #{session[:secret_word_array].join}."
end

get '/lose' do
  "You lose!!! The word was #{session[:secret_word_array].join}."
end


helpers do

  def compare_guess(guess)
    if guess.size == 1
      session[:secret_word_array].each_with_index do  |letter,index|
        if guess == letter
          session[:hangman_layout][index] = letter
          session[:victory_condition] = true if session[:hangman_layout] == session[:secret_word_array]
        end
      end
    else
      if guess.split('') == session[:secret_word_array]
        session[:victory_condition] = true
      end
    end
  end

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