# frozen_string_literal: true

class Position
  attr_accessor :name, :position

  def initialize(name, position)
    @name = name
    @position = position
  end
end
