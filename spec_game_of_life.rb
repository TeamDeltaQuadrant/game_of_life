# Spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of life' do

  let!(:world){ World.new }
  let!(:cell){ Cell.new(1, 1) }

  context 'World' do
    subject { World.new }

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
      expect(subject).to respond_to(:live_neighbours_around_cell)
      expect(subject).to respond_to(:cells)
    end
    it 'should create proper cell grid on initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be true

      subject.cell_grid.each do |row|
        expect(row.is_a?(Array)).to be true
        row.each do |col|
          expect(col.is_a?(Cell)).to be true
        end
      end
    end

    it 'should add all cells to cells array' do
      expect(subject.cells.count).to eq(9)
      expect(subject.cells.count).to eq(9)
    end

    it 'should detect a neighbour to the north' do
      subject.cell_grid[cell.y - 1][cell.x].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the north east' do
      subject.cell_grid[cell.y - 1][cell.x + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the east' do
      subject.cell_grid[cell.y][cell.x + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the south east' do
      subject.cell_grid[cell.y + 1][cell.x + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the south' do
      subject.cell_grid[cell.y + 1][cell.x].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the south west' do
      subject.cell_grid[cell.y + 1][cell.x - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the west' do
      subject.cell_grid[cell.y][cell.x - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it 'should detect a neighbour to the north west' do
      subject.cell_grid[cell.y - 1][cell.x - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to eq(1)
    end

  end

  context 'Cell' do
    subject {Cell.new}

    it 'should create a new cell object' do
      expect(subject.is_a?(Cell)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:die!)
    end
    it 'should initzialize properly' do
      expect(subject.alive).to be false
      expect(subject.x).to be(0)
      expect(subject.y).to be(0)
    end
  end

  context 'Game' do
    subject { Game.new }

    it 'should create new Game object' do
      expect(subject.is_a?(Game)).to be true
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end

    it 'should initzialize properly' do
      expect(subject.world.is_a?(World)).to be true
      expect(subject.seeds.is_a?(Array)).to be true
    end

    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 0], [2, 0]])
      expect(world.cell_grid[1][0]).to be_alive
      expect(world.cell_grid[2][0]).to be_alive
    end
  end

  context 'Rules' do
    let!(:game){Game.new}
    context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
      it 'should kill a alive cell with no neighbours' do
        game.world.cell_grid[1][1].alive = true
        expect(game.world.cell_grid[1][1]).to be_alive
        game.tick!
        expect(game.world.cell_grid[1][1]).to be_dead
      end

      it 'should kill a alive cell with one alive neighbour' do
        game = Game.new(world, [[1, 0], [2, 0]])
        game.tick!
        expect(world.cell_grid[1][0]).to be_dead
        expect(world.cell_grid[2][0]).to be_dead
      end

      it 'should kill a alive cell with two alive neighbour' do
        game = Game.new(world, [[0, 1], [2, 1], [1, 1]])
        game.tick!
        expect(world.cell_grid[1][1]).to be_alive
      end
    end

    context 'Rule 2: Any live cell with two or three live neighbours lives on to the next generation.' do
      it 'should keep cell alive that has two alive neighbours' do
        game = Game.new(world, [[0, 1], [2, 1], [1, 1]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to eq(2)
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[1][1]).to be_alive
        expect(world.cell_grid[2][1]).to be_dead
      end

      it 'should keep cell alive that has three alive neighbours' do
        game = Game.new(world, [[0, 1], [2, 1], [1, 1], [2, 2]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to eq(3)
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[1][1]).to be_alive
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
      end
    end

    context 'Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding.' do
      it 'should kill a alive cell with four alive neighbours' do
        game = Game.new(world, [[0, 1], [2, 1], [1, 1], [2, 2], [1, 2]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to eq(4)
        game.tick!
        expect(world.cell_grid[0][1]).to be_alive
        expect(world.cell_grid[1][1]).to be_dead
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
        expect(world.cell_grid[1][2]).to be_dead
      end
    end

    context 'Rule 4: Any dead cell with excactly three live neighbours becomes a live cell, as if by rerpoduction.' do
      it 'revives dead cells with three alive neighbours' do
        game = Game.new(world, [[0, 1], [2, 1], [1, 1]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][0]).count).to eq(3)
        game.tick!
        expect(world.cell_grid[1][0]).to be_alive
        expect(world.cell_grid[1][2]).to be_alive
      end
    end
  end
end
