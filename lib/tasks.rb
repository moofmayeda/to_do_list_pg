require 'pg'

class Task
  attr_accessor :name, :list_id

  def initialize name, id
    @name = name
    @list_id = id
  end

  def self.all
    tasks = []
    results = DB.exec("SELECT * FROM tasks;")
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id'].to_i
      done = result['done']
      tasks << Task.new(name, list_id)
    end
    tasks
  end

  def self.find(number)
    tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE list_id = #{number};")
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id'].to_i
      done = result['done']
      tasks << Task.new(name, list_id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{name}', #{list_id});")
  end

  def == another_task
    self.name == another_task.name && self.list_id == another_task.list_id
  end
end
