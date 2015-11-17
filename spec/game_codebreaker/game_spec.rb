require 'spec_helper'

module GameCodebreaker

	describe Game do

    let(:game) { Game.new }
    # let(:game_over) { Game.new(game_over: true) }

    context "generate_code" do
      it 'must return the string with digits between 1..6' do
        game.generate_code
        expect(game.code).to match(/[1-6]+/)
      end
    end

    context "process" do

      let(:skynet) { "1234".split(//) }

      it 'with input the string "0000"' do
        human = "0000".split(//)
        expect( game.process(skynet, human) ).to eq( "" )
      end

      it 'with input the string "0001"' do
        human = "0001".split(//)
        expect( game.process(skynet, human) ).to eq( "-" )
      end

      it 'with input the string "1111"' do
        human = "1111".split(//)
        expect( game.process(skynet, human) ).to eq( "+" )
      end

      it 'with input the string "1200"' do
        human = "1200".split(//)
        expect( game.process(skynet, human) ).to eq( "++" )
      end

      it 'with input the string "1243"' do
        human = "1243".split(//)
        expect( game.process(skynet, human) ).to eq( "++--" )
      end

      it 'with input the string "1234"' do
        human = "1234".split(//)
        expect( game.process(skynet, human) ).to eq( "++++" )
      end

      it 'with input the string "4321"' do
        human = "4321".split(//)
        expect( game.process(skynet, human) ).to eq( "----" )
      end

      context '' do

        let(:skynet) { "0011".split(//) }

        it 'with repeating digits in code' do
          human = "0123".split(//)
          expect( game.process(skynet, human) ).to eq( "+-" )
        end

        it 'with repeating digits in code' do
          human = "1100".split(//)
          expect( game.process(skynet, human) ).to eq( "----" )
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

      it 'when (string = "get hint"), turns not be changed' do
        string = "get hint"
        allow(game).to receive(:get_hint).and_return(true)
        expect{ game.respond( string ) }.not_to change{ game.turns }
      end

      it 'standard behavior - turns must be changed' do
        allow(game).to receive(:game_over).and_return(true)
        allow(game).to receive(:process).and_return(true)
        expect{ game.respond( string ) }.to change{ game.turns }.by(1)
      end

      it 'standard behavior - @history must to have the array' do
        game3.respond( string )
        allow(game).to receive(:game_over).and_return(true)
        allow(game).to receive(:process).and_return("++++")
        expect( game3.history ).to include( ["1234", "1234", "++++"] )
      end
    end

    context "get_hint" do

      let(:game) { Game.new( code: "12", length: 2, hints: ["1-"] ) }

      it 'hints must not be repeating ' do
        game.get_hint
        expect( game.hints ).to include( "1-").and include ("-2") 
      end

    end

	end
end














