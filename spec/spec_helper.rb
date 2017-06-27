$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kazoo-client'
require 'webmock/rspec'

def fixture(file)
  File.new(File.expand_path('../fixtures', __FILE__) + '/' + file)
end
