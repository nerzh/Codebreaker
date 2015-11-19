require 'spec_helper'

module GameCodebreaker

  describe User do

    context 'hash' do
      let(:game) { Game.new }
      let(:user) { User.new( "Name", "Surname", "25", [game] ) }

      it "return control sum" do
        expect( user.hash ).to  eq( ["Name", "Surname"].hash )
      end

    end

  end

end