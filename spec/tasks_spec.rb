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



  describe '.select' do
    it "selects a task by its ID number" do
      new_task1 = Task.new('pull weeds', 1)
      new_task1.save
      new_task2 = Task.new('water plants', 2)
      new_task2.save
      id = new_task1.id
      expect(Task.select(id)).to eq new_task1
    end
  end

  describe '.find_completed' do
    it 'finds completed tasks' do
      new_task1 = Task.new('pull weeds', 2)
      new_task1.save
      new_task1.mark_done
      new_task2 = Task.new('water plants', 2)
      new_task2.save
      new_task2.mark_done
      new_task3 = Task.new('dig hole', 1)
      new_task3.save
      new_task3.mark_done
      new_task4 = Task.new('trim tree', 3)
      new_task4.save
      expect(Task.find_completed(2)).to eq [new_task1, new_task2]
    end
  end

  describe '.delete' do
    it 'deletes a given task from the database' do
      new_task = Task.new('pull weeds', 1)
      new_task.save
      Task.delete(new_task)
      expect(Task.all).to eq []
    end
  end

  describe 'edit_date' do
    it 'lets you edit the due date' do
      new_task = Task.new('scrub gulfstream jet', 1)
      new_task.save
      new_task.edit_date('2014-08-20')
      expect(new_task.due_date).to eq '2014-08-20'
    end
  end

  describe 'mark_done' do
    it 'lets you mark the task as done' do
      new_task = Task.new('scrub gulfstream jet', 1)
      new_task.save
      new_task.mark_done
      expect(new_task.done).to eq true
    end
  end

  describe '.sort_by_date' do
    it 'finds all tasks in a list and sorts them by date' do
      new_task1 = Task.new('pull weeds', 2)
      new_task1.save
      new_task1.edit_date('2014-08-31')
      new_task2 = Task.new('water plants', 2)
      new_task2.save
      new_task2.edit_date('2014-08-30')
      new_task3 = Task.new('dig hole', 2)
      new_task3.save
      new_task3.edit_date('2014-07-31')
      new_task4 = Task.new('trim tree', 3)
      new_task4.save
      expect(Task.sort_by_date(2)).to eq [new_task3, new_task2, new_task1]
    end
  end
end
