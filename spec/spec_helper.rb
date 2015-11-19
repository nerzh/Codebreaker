# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'game_codebreaker'
require 'rspec/collection_matchers'
load 'bin/game_codebreaker'




RSpec.configure do |config|

  config.after(:each) do
    dir = "./spec/game_codebreaker/fixtures/save_dump"
    File.delete( dir ) if File.exists?( dir )
  end

end