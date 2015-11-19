require 'spec_helper'

module GameCodebreaker

  describe Memory do

    let(:memory) { Memory.new( "./spec/game_codebreaker/fixtures/dump" ) }
    let(:memory2) { Memory.new( "./spec/game_codebreaker/fixtures/save_dump" ) }
    let(:game) { Game.new }
    let(:user) { User.new( "Name", "Surname", "25", [] ) }
    let(:user2) { User.new( "Name", "Surname", "25", [game] ) }
    let(:user3) { User.new( "Name2", "Surname2", "25", [] ) }

    context 'initialize' do

      it "must to have users" do
        expect( memory.users ).not_to eq( [] )
      end

      it "must not to have users" do
        expect( memory2.users ).to eq( [] )
      end

    end

    context 'add_games' do
      it "add game to user" do
        memory.users = [user]
        memory.add_games( user2 )
        expect( memory.users.first.games ).to include( game )
      end
    end

    context 'exists?' do
      it "user must be exist" do
        memory.users = [user]
        expect( memory.exists?( user ) ).to eq( true )
      end

      it "user must not to be existent" do
        memory.users = [user]
        expect( memory.exists?( user3 ) ).to eq( false )
      end
    end

    context 'get_user' do     
      it "get user" do
        memory.users = [user]
        expect( memory.get_user( user ) ).to eq( user )
      end
    end

    context 'info' do
      it "user info" do
        memory.users = [user2]
        expect( memory.info( user2 ).size ).to eq( 8 )
      end
    end

    context 'save' do
      it "save user" do
        allow(memory).to receive(:exists?).and_return(false)
        memory2.save( user2 )
        expect( File.exists?( memory2.path ) ).to eq( true )
      end
    end

    context 'load' do
      it "must be returned object of class Memory" do
        expect( memory.load.class ).to eq( Memory )
      end
    end

  end

end