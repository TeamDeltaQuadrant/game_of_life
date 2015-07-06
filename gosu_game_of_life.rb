# Gosu File
require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(height = 800, width = 600)
    @height = height
    @width = width
    super height, width, false
    self.caption = 'Our Game of Life'

    # Color
    @background_color = Gosu::Color.new(0xffdedede)

    # Game itself
    @cols = width/10
    @rows = height/10
    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
    @game.world.randomly_populate
  end

  def update
  end

  def draw
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)
  end

  def needs_cursor?; true; end

end

GameOfLifeWindow.new.show
