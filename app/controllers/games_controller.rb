require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = *("A".."Z")
    @ten_letter = []
    10.times do
    @ten_letter <<  @letters.shuffle.first
    end
  end

  def score
    @word = (params[:word] || "").upcase
    @letters = params[:ten_letter].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized_word = URI.open(url).read
    word_dico = JSON.parse(serialized_word)
    word_dico['found']
  end

end