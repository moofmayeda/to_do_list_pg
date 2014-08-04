require 'rspec'
require 'pry'
require 'lists'

DB = PG.connect({:dbname => 'test_todo'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe 'List' do
  describe 'initialize' do
    it 'initializes a new task with a name' do
      new_list = List.new('pull weeds')
      expect(new_list).to be_an_instance_of List
      expect(new_list.name).to eq 'pull weeds'
    end
  end

  describe '.all' do
    it 'starts as a blank array' do
      expect(List.all).to eq []
    end
  end

  describe 'save' do
    it 'saves a list' do
      new_list = List.new('pull weeds')
      new_list.save
      expect(List.all[0]).to eq new_list
    end
  end

  describe '==' do
    it "sets two lists as equal if they have the same name" do
      new_list1 = Task.new('pull weeds')
      new_list2 = Task.new('pull weeds')
      expect(new_list1).to eq new_list2
    end
  end
end
