require 'pg'

class List
  attr_accessor :name

  def initialize name
    @name = name
  end
end
