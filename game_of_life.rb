# Basic file
class Game
  attr_accessor :world, :seeds
  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid
  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cell_grid = Array.new(rows) do |row|
                    Array.new(cols) do |col|
                      Cell.new(row, col)
                    end
                end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    # it detects a neighbour to the north

    #   for i in -1..1 do
    #       for j in -1..1 do
    #         if self.cell_grid.include?([cell.x+i][cell.y+j])
    #           candidate = self.cell_grid[cell.x+i][cell.y+j]
    #           puts candidate
    #           live_neighbours << candidate if candidate.alive?
    #         end
    #       end
    #   end
    #
    #
    # puts live_neighbours
    live_neighbours
  end
end

class Cell
  attr_accessor :alive, :x, :y
  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end
  def dead?; !alive; end
end
