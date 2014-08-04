require 'todo_spec'

describe 'List' do
  describe 'initialize' do
    it 'can be initialized with its name and database ID' do
      new_list = List.new('pull weeds', 1)
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
      new_list1 = List.new('pull weeds')
      new_list2 = List.new('pull weeds')
      expect(new_list1).to eq new_list2
    end
  end

  it "sets its ID when you save it" do
    list = List.new('gardening')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end
end
