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

  def tick!
    next_round_live_cells = []
    next_round_dead_cells = []

    world.cells.each do |cell|
      neighbours = world.live_neighbours_around_cell(cell).count

      #Rule 1
      if cell.alive? && neighbours < 2
        next_round_dead_cells << cell
      end

      #Rule 2
      if cell.alive? && [2, 3].include?(neighbours)
        next_round_live_cells << cell

      end

      #Rule 3
      if cell.alive? && neighbours > 3
        next_round_dead_cells << cell
      end

      #Rule 4
      if cell.dead? && neighbours == 3
        next_round_live_cells << cell
      end
    end

    next_round_live_cells.each do |cell|
      cell.revive!
    end

    next_round_dead_cells.each do |cell|
      cell.die!
    end

  end

end

class World
  attr_accessor :rows, :cols, :cell_grid, :cells
  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []
    @cell_grid = Array.new(rows) do |row|
                    Array.new(cols) do |col|
                      cell = Cell.new(col, row)
                      cells << cell
                      cell
                    end
                end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    # it detects a neighbour to the north east
    if cell.y > 0 && cell.x < (cols - 1)
      candidate = @cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the south east
    if cell.y < (rows - 1) && cell.x < (cols - 1)
      candidate = @cell_grid[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the south west
    if cell.y < (rows - 1) && cell.x > 0
      candidate = @cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the north west
    if cell.y > 0 && cell.x > 0
      candidate = @cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the north
    if cell.y > 0
      candidate = @cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the east
    if cell.x < (cols - 1)
      candidate = @cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the south
    if cell.y < (rows - 1)
      candidate = @cell_grid[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # it detects a neighbour to the west
    if cell.x > 0
      candidate = @cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    live_neighbours
  end
end

class Cell
  attr_accessor :alive, :x, :y
  def initialize(x = 0, y = 0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end

  def dead?; !alive; end

  def revive!
    @alive = true
  end

  def die!
    @alive = false
  end

end
