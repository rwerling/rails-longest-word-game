require 'net/http'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @answer = params[:answer]
    @letters = JSON.parse(params[:letters])
    @check_word = JSON.parse(Net::HTTP.get(URI.parse("https://wagon-dictionary.herokuapp.com/#{@answer}")))
    if @check_word['found'] == false
      @message = "#{@answer} is not an english word"
    elsif @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) } == false
      @message = "#{@answer} can not be built out of #{@letters}"
    elsif @check_word['found'] == true && @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
      @message = "#{@answer} was found! :-) #{@check_word['length']} Points"
    end
  end
end
