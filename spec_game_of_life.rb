# Spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of life' do

  context 'World' do
    subject {World.new}

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
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
    end
    it 'should initzialize properly' do
      expect(subject.alive).to be false
    end
  end

end
