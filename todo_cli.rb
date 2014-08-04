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
    puts task.name
  end
  add_task(list_id)
end

def add_task list_id
  puts "Press n to add a new task to this list"
  puts "M > Main Menu"
  case gets.chomp.upcase
  when 'N'
    puts "Enter the task"
    Task.new(gets.chomp, list_id).save
    add_task(list_id)
  when 'M'
    main_menu
  end
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
