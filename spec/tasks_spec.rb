require 'todo_spec'

describe 'Task' do
  describe 'initialize' do
    it 'initializes with a name and list id' do
      new_task = Task.new('pull weeds', 1)
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
      new_task = Task.new('pull weeds', 1)
      new_task.save
      expect(Task.all[0]).to eq new_task
    end
  end

  describe '==' do
    it "sets two tasks as equal if they have the same name" do
      new_task1 = Task.new('pull weeds', 1)
      new_task2 = Task.new('pull weeds', 1)
      expect(new_task1).to eq new_task2
    end
  end

  describe '.find' do
    it 'finds tasks which match given params' do
      new_task1 = Task.new('pull weeds', 1)
      new_task1.save
      new_task2 = Task.new('water plants', 2)
      new_task2.save
      new_task3 = Task.new('dig hole', 2)
      new_task3.save
      new_task4 = Task.new('trim tree', 3)
      new_task4.save
      expect(Task.find(2)).to eq [new_task2, new_task3]
    end
  end
end
