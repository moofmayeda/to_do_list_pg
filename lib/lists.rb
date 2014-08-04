require 'pg'
require 'pry'
class List
  attr_accessor :name
  attr_reader :id

  def initialize name, id = nil
    @name = name
    @id = id.to_i
  end

  def self.all
    lists = []
    results = DB.exec("SELECT * FROM lists;")
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def self.find id
    result = DB.exec("SELECT * FROM lists WHERE id = #{id};").first
    List.new(result['name'], result['id'])
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def == another_list
    self.name == another_list.name && self.id == another_list.id
  end
end
