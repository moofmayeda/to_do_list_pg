require 'rspec'
require 'pry'
require 'tasks'

DB = PG.connect({:dbname => 'test_todo'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe 'Task' do
  describe 'initialize' do
    it 'initializes a new task with a name' do
      new_task = Task.new('pull weeds')
      expect(new_task).to be_an_instance_of Task
      expect(new_task.name).to eq 'pull weeds'
    end
  end

  describe '.all' do
    it 'starts as a blank array' do
      expect(Task.all).to eq []
    end
  end

  describe 'save' do
    it 'saves a task' do
      new_task = Task.new('pull weeds')
      new_task.save
      expect(Task.all[0]).to eq new_task
    end
  end

  describe '==' do
    it "sets two tasks as equal if they have the same name" do
      new_task1 = Task.new('pull weeds')
      new_task2 = Task.new('pull weeds')
      expect(new_task1).to eq new_task2
    end
  end
end
