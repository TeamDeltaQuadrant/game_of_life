# Gosu File
require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize
    super 800, 600, false
    self.caption = 'Our Game of Life'
  end

  def update
  end

  def draw
  end

end

GameOfLifeWindow.new.show
