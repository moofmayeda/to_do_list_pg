require 'pg'
require './lib/tasks'
require './lib/lists'

DB = PG.connect({:dbname => 'todo'})

def ws
  puts "\n"
end

def welcome
  system 'clear'
  puts "*"*88
  puts "Your To-Do List"
  puts "*"*88
  ws
end

def lists
  List.all.each do |list|
    puts list.id.to_s + " " + list.name
  end
  ws
end

def create_list
  welcome
  puts "Enter the name of the list"
  List.new(gets.chomp).save
  main_menu
end

def view_list list_query
  welcome
  list_id = list_query.id
  puts list_query.id.to_s + " " + list_query.name
  ws
  puts "Tasks:"

  Task.find(list_query.id).each do |task|
    puts task.id.to_s + ") " + task.name + ", Due: " + task.due_date.to_s
  end
  add_task(list_id)
end

def add_task list_id
  puts "Press n to add a new task to this list"
  puts "Or enter the number to modify a task"
  puts "M > Main Menu"
  response = gets.chomp.upcase
  case response
  when 'N'
    puts "Enter the task"
    Task.new(gets.chomp, list_id).save
    add_task(list_id)
  when 'M'
    main_menu
  else
    task_query = Task.select(response.to_i)
    view_task(task_query)
  end
end

def view_task task_query
  welcome
  task_id = task_query.id
  puts task_query.id.to_s + " " + task_query.name
  puts "Due Date: " + task_query.due_date.to_s
  puts "Completed: " + task_query.done.to_s
  ws
  puts "Press r to remove the task"
  puts "Press d to add a due date"
  puts "Press c to mark a task 'completed'"
    choice = gets.chomp.upcase
      case choice
      when 'R'
        Task.delete(task_query)
        add_task(task_query.list_id)
      when 'D'
        puts "Enter due date (YEAR-MN-DY):"
        task_query.edit_date(gets.chomp)
      when 'C'
        task_query.mark_done
      end
  add_task(task_query.list_id)
end

def main_menu
  welcome
  lists
  puts "N - Create a new list"
  puts "X - Exit"
  puts "Or enter the number of a list to modify it:"
  response = gets.chomp.upcase
  case response
  when 'N'
    create_list
  when 'X'
    exit
  else
    list_query = List.find(response.to_i)
    view_list(list_query)
  end

end

main_menu
