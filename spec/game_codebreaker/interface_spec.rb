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
        expect(interface).to receive(:question).and_return('exit')
        expect{ interface.play(game) }.to raise_error SystemExit
      end

      # it 'standard behavior' do
      #   Interface.class_eval do
      #     alias :play2 :play
      #   end
      #   expect(interface).to receive(:question)
      #   expect(interface).to receive(:get_hint)
      #   expect(interface).to receive(:cheat)
      #   expect(game).to receive(:respond)
      #   expect(interface).to receive(:p)
      #   interface.stub_chain(:game, :history, :last, :last)
      #   expect(interface).to receive(:get_hint)
      #   expect(interface).to receive(:game_over?)
      #   interface.play2(game)
      # end
    end

    context "mess" do
      it { expect(interface.mess :enter).to eq(%Q^ Enter your integer and press 'Enter' ^) }
      it { expect(interface.mess :replay).to eq(%Q^ Replay ? -- Y/N ^) }
      it { expect(interface.mess :level).to eq(%Q^ Select and enter level. ( low | normal | hard ) ^) }
      it { expect(interface.mess :save).to eq(%Q^ Save games? -- Y/N ^) }
      it { expect(interface.mess :collector).to eq(%Q^ I am waiting the GARBAGE COLLECTOR ^) }
      it { expect(interface.mess :data).to eq(%Q^ Please enter your data separated by a space and press 'Enter'. Example: Name Surname Age ^) }
      it { expect(interface.mess :length).to eq(%Q^ Please enter quantity digits ^) }
      it { expect(interface.mess :else).to eq(%Q^ читер ? ^) }
    end

    context "question" do
      it 'must to return entered value' do
        $stdin.stub_chain(:gets, :chomp)
        expect(interface).to receive(:p).with('test')
        interface.question('test')
      end
    end

    context "out" do
      it 'must return message and get out of this programm' do
        expect(interface).to receive(:p).with(%Q^ I am waiting the GARBAGE COLLECTOR ^)
        expect{ interface.out }.to raise_error SystemExit
      end
    end

    context "get_hint" do
      it 'must called get_hint, p and play' do
        expect(game).to receive(:get_hint)
        expect(interface).to receive(:p)
        expect(interface).to receive(:play)
        interface.get_hint('get hint', game)
      end
    end

    context "cheat" do
      it 'must called p with code and play' do
        expect(interface).to receive(:p).with(game.code)
        expect(interface).to receive(:play)
        interface.cheat('cheat', game)
      end
    end

    context "game_over?" do
      it 'game_over == false' do
        expect( interface.game_over?(game) ).to eq(nil)
      end

      context 'game_over == true' do
        before(:each) do
          allow(interface).to receive(:restart?)
          allow(interface).to receive(:save?)
          allow(interface).to receive(:out)
        end
        
        it 'if win' do
          game = Game.new(code: '1234', game_over: true, win: true)
          expect(interface).to receive(:p).with('YOU WIN !')
          interface.game_over?(game)
        end

        it 'if lose' do
          game = Game.new(code: '1234', game_over: true, win: false)
          expect(interface).to receive(:p).with(game.code)
          expect(interface).to receive(:p).with('YOU LOSE !')
          interface.game_over?(game)
        end
      end
    end

    context 'get_user_data' do
      it 'valid data' do
        allow(interface).to receive(:question).and_return('Name Surname 100')
        expect(interface.get_user_data).to eq(['Name', 'Surname', '100'])
      end

      # it 'invalid data' do
      #   allow(interface).to receive(:question).and_return('NameSurname 100')
      #   expect(interface.get_user_data).to eq(false)
      # end
    end

    context 'restart?' do
      it 'restart game' do
        allow(interface).to receive(:question).and_return('y')
        expect(interface).to receive(:start)
        interface.restart?(game)
        expect( interface.instance_variable_get(:@games) ).to include( game )
      end

      it 'end game' do
        allow(interface).to receive(:question).and_return('n')
        expect(interface).to receive(:start).never
        expect( interface.restart?(game) ).to eq(nil)
      end
    end

    context 'save?' do
      # it 'save game' do
      # end

      it 'not save game' do
        expect(interface).to receive(:question).and_return('n')
        expect( interface.save?(game) ).to eq(nil)
      end
    end

    context 'print_info' do
      array = '12345678'.split(//)
      it 'print info' do
        expect(interface).to receive(:p).with('Name:                    1')
        expect(interface).to receive(:p).with('Surname:                 2')
        expect(interface).to receive(:p).with('Age                      3')
        expect(interface).to receive(:p).with('Total games              4')
        expect(interface).to receive(:p).with('Total wins               5')
        expect(interface).to receive(:p).with('Total losses             6')
        expect(interface).to receive(:p).with('Average amount of turns  7')
        expect(interface).to receive(:p).with('Average amount of level  8')
        interface.print_info(array)
      end
    end

  end
end


