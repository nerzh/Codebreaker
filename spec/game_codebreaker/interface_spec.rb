require 'spec_helper'

module GameCodebreaker

  describe Interface do

    let(:interface) { Interface.new }
    let(:game) { Game.new(code: '1234') }

    context "start" do
      it 'create object game with params and receive method \'play\'' do
        expect(interface).to receive(:question).and_return( 'low', '5' )
        expect(Game).to receive(:new).with(length: 5, hint: 2, level: 15)
        expect(interface).to receive(:play)
        interface.start
      end
    end

    context "play" do
      it 'out of this programm if string eq \'exit\'' do
        expect(interface).to receive(:question).and_return( 'exit' )
        expect(interface).to receive(:p).and_return( nil )
        # expect(interface).to receive(:start).and_return( 'low', '5' )
        # expect(interface).to receive(:out)
        expect{ interface.play( game ) }.to raise_error SystemExit
      end

      it 'show code if string eq \'cheat\'' do
        Interface.class_eval do
            alias :play2 :play
        end
        interface = Interface.new
        # expect(interface).to receive(:mess).and_return( 'hello' )
        expect(interface).to receive(:question).and_return( 'cheat' )
        # expect(Game).to receive(:new).with(length: 5, hint: 2, level: 15)
        expect(interface).to receive(:p).with('1234')
        # interface.should_receive(:play).with( game )
        # expect(interface).to receive(:play).and_return( nil )
        # interface.should_receive(:play).with( game )
        # byebug
        # expect(interface).to receive(:p).with('1234')
        should_receive(:play)
        interface.play( game )
        # expect(interface).to receive(:p).with('1234')
        # interface.should_receive(:play).with( game )
        # expect(interface).to receive(:play).and_return( nil )
        # expect{ interface.play( game ) }.to raise_error SystemExit
      end
    end

  end

end