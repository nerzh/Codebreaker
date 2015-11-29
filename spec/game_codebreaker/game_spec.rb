require 'spec_helper'

module GameCodebreaker

  describe Game do

    let(:game) { Game.new }

    context "initialize" do
      it 'return error if Length code must not be equal to variable with name \'length\'' do
        expect{ Game.new( code: '1234', length: 5) }.to raise_error
      end

      it 'code is not changed' do
        game = Game.new( code: '5555' )
        expect( game.code ).to eq( '5555' )
      end

      it 'code must be exists' do
        expect( game.code ).not_to eq( '' )
      end
    end

    context "generate_code" do
      it 'must return the string with digits between 1..6' do
        game.send( :generate_code )
        expect(game.code).to match(/[1-6]+/)
      end
    end

    context "process" do

      let(:skynet) { "1234".split(//) }

      it 'with input the string "0000"' do
        human = "0000".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "" )
      end

      it 'with input the string "0001"' do
        human = "0001".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "-" )
      end

      it 'with input the string "1111"' do
        human = "1111".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "+" )
      end

      it 'with input the string "1200"' do
        human = "1200".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "++" )
      end

      it 'with input the string "1243"' do
        human = "1243".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "++--" )
      end

      it 'with input the string "1234"' do
        human = "1234".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "++++" )
      end

      it 'with input the string "4321"' do
        human = "4321".split(//)
        expect( game.send( :process, skynet, human ) ).to eq( "----" )
      end

      context 'repeating' do

        let(:skynet) { "0011".split(//) }

        it 'with repeating digits in code' do
          human = "0123".split(//)
          expect( game.send( :process, skynet, human ) ).to eq( "+-" )
        end

        it 'with repeating digits in code' do
          human = "1100".split(//)
          expect( game.send( :process, skynet, human ) ).to eq( "----" )
        end

      end

    end

    context "respond" do

      let(:string) { "1234" }
      let(:game2) { Game.new( code: "1234", game_over: true ) }
      let(:game3) { Game.new( code: "1234" ) }

      it 'when (game_over = true), turns not be changed' do
        expect{ game2.respond( string ) }.not_to change{ game.turns }
      end

      it 'standard behavior - turns must be changed' do
        allow(game).to receive(:check_game).and_return(true)
        allow(game).to receive(:process).and_return(true)
        expect{ game.respond( string ) }.to change{ game.turns }.by(1)
      end

      it 'standard behavior - @history must to have the array' do
        game3.respond( string )
        allow(game).to receive(:check_game).and_return(true)
        allow(game).to receive(:process).and_return("++++")
        expect( game3.history ).to include( ["1234", "1234", "++++"] )
      end
    end

    context "get_hint" do

      let(:game) { Game.new( code: "12", length: 2, hints: ["1-"] ) }

      it 'hints must not be repeating ' do
        game.get_hint
        expect( game.hints ).to eq( ["1-", "-2"] )
      end

      it 'hint must be change' do
        game.get_hint
        expect{ game.get_hint }.to change{ game.hint }.by(-1) 
      end

    end

    context "check_game" do

      let(:game2) { Game.new( turns: 15 ) } 

      it 'you win and game over' do
        game.check_game( "++++" )
        expect( game.win? ).to eq( true )
        expect( game.game_over? ).to eq( true )
      end

      it 'you lose and game over' do
        game2.check_game( "+++-" )
        expect( game2.win? ).to eq( false )
        expect( game2.game_over? ).to eq( true )
      end

    end

  end
end


