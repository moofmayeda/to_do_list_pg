require 'rspec'
require 'pry'
require 'tasks'

describe 'Task' do
  it 'initializes a new task with a name' do
    new_task = Task.new('pull weeds')
    expect(new_task).to be_an_instance_of Task
    expect(new_task.name).to eq 'pull weeds'
  end
end
