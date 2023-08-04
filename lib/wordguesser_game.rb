class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses , :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @try = 0
  end

  def word_with_guesses
    display = ''
    @word.each_char do |c|
      if @guesses.include? c
        display += c
      else
        display += '-'
      end
    end
    display
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @try >= 7
    return :play if @try < 7
  end

  def guess(letters)

    if letters.nil? || letters.empty? || !letters.match?(/[a-zA-Z]/)
      raise ArgumentError
    end

    letters = letters.downcase 
    arr = letters.chars

    for letter in arr do
      @try += 1
      if @word.include?(letter)
        if !guesses.include?(letter)
          @guesses += letter 
          return true
        else
          return false
        end
      else
        if !wrong_guesses.include?(letter)
          @wrong_guesses += letter 
          return true
        else
          return false
        end
      end
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end