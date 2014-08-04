require 'rspec'
require 'pry'
require 'lists'
require 'tasks'

DB = PG.connect({:dbname => 'test_todo'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
    DB.exec("DELETE FROM tasks *;")
  end
end
