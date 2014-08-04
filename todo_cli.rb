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
  puts "Enter the name of the list"
  List.new(gets.chomp).save
  main_menu
end

def list_detail
  lists
  puts "Enter the number of the list to view:"
  list_num = gets.chomp.to_i

  list_query = List.find(list_num)
  view_list(list_query)
end

def view_list list_query
  puts list_query.id.to_s + " " + list_query.name
end


def main_menu
  welcome
  lists
  puts "1 - Create a new list"
  puts "2 - Edit or search an existing list"
  puts "3 - exit"
  case gets.chomp.to_i
  when 1
    create_list
  when 2
    list_detail
  when 3
    exit
  end

end

main_menu
