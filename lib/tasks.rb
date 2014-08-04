require 'pg'

class Task
  attr_accessor :name

  def initialize name
    @name = name
  end

  def self.all
    tasks = []
    results = DB.exec("SELECT * FROM tasks;")
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id']
      done = result['done']
      tasks << Task.new(name)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name) VALUES ('#{name}');")
  end

  def == another_task
    self.name == another_task.name
  end
end
