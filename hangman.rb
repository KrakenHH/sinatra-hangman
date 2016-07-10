
class Hangman

  require 'yaml'

  attr_accessor :turn_counter,  :correct_guesses, :guessed_array

  def initialize
    @secret_word = random_word_giver
    @secret_word_letters = @secret_word.split("")
    @correct_guesses = []
    @secret_word_letters.size.times { @correct_guesses << "_" }
    @turn_counter = 15
    @guessed_array = []
  end

  def guess_letter_or_word(str)
    if str.length > 1
      guess_word(str)
    else
      guess_letter(str)
    end
  end

  def guess_word(word)
    if word = @secret_word
      "VICTORY, WORD = #{@secret_word}"
    else
      @guessed_array << word
      detract_counter
      "#{word} is not the correct word."
    end
  end

  def guess_letter(l)
    if @secret_word_letters.include?(l)
      guess_array << word
      @secret_word.each_with_index { |letter, index| @correct_guesses[index] = l if letter == l }
      "#{letter} is in the word."
    else
      detract_counter
      @guessed_array << word
      "#{letter} is not in the word."
    end
  end

  def detract_counter
    @turn_counter -= 1
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

