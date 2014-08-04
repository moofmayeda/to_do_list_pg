require 'pg'

class Task
  attr_accessor :name, :list_id, :due_date, :done
  attr_reader :id

  def initialize name, list_id, id = nil, due_date = nil, done = false
    @name = name
    @list_id = list_id
    @id = id.to_i
    @due_date = due_date
    @done = done
  end

  def self.all
    tasks = []
    results = DB.exec("SELECT * FROM tasks;")
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id'].to_i
      done = result['done']
      id = result['id']
      tasks << Task.new(name, list_id, id)
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
      id = result['id']
      tasks << Task.new(name, list_id, id)
    end
    tasks
  end

   def self.sort_by_date(number)
    tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE list_id = #{number} ORDER BY due_date ASC;")
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id'].to_i
      done = result['done']
      id = result['id']
      tasks << Task.new(name, list_id, id)
    end
    tasks
  end

  def save
    result = DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{name}', #{list_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def == another_task
    self.name == another_task.name && self.list_id == another_task.list_id
  end

  def self.select(id_num)
    result = DB.exec("SELECT * FROM tasks WHERE id = #{id_num};").first
    Task.new(result['name'], result['list_id'].to_i, result['id'].to_i, result['due_date'], result['done'])
  end

  def self.delete(task)
    DB.exec("DELETE FROM tasks WHERE name = '#{task.name}';")
  end

  def edit_date(date)
    DB.exec("UPDATE tasks SET due_date = '#{date}' WHERE id = #{id};")
    @due_date = date
  end

  def mark_done
    DB.exec("UPDATE tasks SET done = true WHERE id = #{id};")
    @done = true
  end
end
