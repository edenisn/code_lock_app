require_relative '../code_lock'
require_relative '../cipher_finder'

describe CipherFinder do
  describe 'happy path' do
    context 'when disc_count = 1' do
      it 'works' do
        code_lock = CodeLock.new(1)
        cipher_finder = CipherFinder.new(from: [0], to: [7], exclude: [[1], [3]])
        expect(cipher_finder.call(code_lock: code_lock))
          .to eq(
            [
              [0],
              [2],
              [4],
              [5],
              [6],
              [7]
            ]
          )
      end
    end

    context 'when disc_count = 2' do
      it 'works' do
        code_lock = CodeLock.new(2)
        cipher_finder = CipherFinder.new(from: [1, 5], to: [2, 3], exclude: [[1, 8], [2, 1]])
        expect(cipher_finder.call(code_lock: code_lock))
          .to eq(
            [
              [1, 5],
              [1, 6],
              [1, 7],
              [1, 9],
              [2, 0],
              [2, 2],
              [2, 3]
            ]
          )
      end
    end

    context 'when disc_count = 3' do
      it 'works' do
        code_lock = CodeLock.new(3)
        cipher_finder = CipherFinder.new(from: [0, 0, 0], to: [1, 1, 1], exclude: [[0, 0, 1], [1, 0, 0]])
        expect(cipher_finder.call(code_lock: code_lock))
          .to eq(
            [
              [0, 0, 0],
              [0, 0, 2],
              [0, 0, 3],
              [0, 0, 4],
              [0, 0, 5],
              [0, 0, 6],
              [0, 0, 7],
              [0, 0, 8],
              [0, 0, 9],
              [0, 1, 0],
              [0, 1, 1],
              [0, 1, 2],
              [0, 1, 3],
              [0, 1, 4],
              [0, 1, 5],
              [0, 1, 6],
              [0, 1, 7],
              [0, 1, 8],
              [0, 1, 9],
              [0, 2, 0],
              [0, 2, 1],
              [0, 2, 2],
              [0, 2, 3],
              [0, 2, 4],
              [0, 2, 5],
              [0, 2, 6],
              [0, 2, 7],
              [0, 2, 8],
              [0, 2, 9],
              [0, 3, 0],
              [0, 3, 1],
              [0, 3, 2],
              [0, 3, 3],
              [0, 3, 4],
              [0, 3, 5],
              [0, 3, 6],
              [0, 3, 7],
              [0, 3, 8],
              [0, 3, 9],
              [0, 4, 0],
              [0, 4, 1],
              [0, 4, 2],
              [0, 4, 3],
              [0, 4, 4],
              [0, 4, 5],
              [0, 4, 6],
              [0, 4, 7],
              [0, 4, 8],
              [0, 4, 9],
              [0, 5, 0],
              [0, 5, 1],
              [0, 5, 2],
              [0, 5, 3],
              [0, 5, 4],
              [0, 5, 5],
              [0, 5, 6],
              [0, 5, 7],
              [0, 5, 8],
              [0, 5, 9],
              [0, 6, 0],
              [0, 6, 1],
              [0, 6, 2],
              [0, 6, 3],
              [0, 6, 4],
              [0, 6, 5],
              [0, 6, 6],
              [0, 6, 7],
              [0, 6, 8],
              [0, 6, 9],
              [0, 7, 0],
              [0, 7, 1],
              [0, 7, 2],
              [0, 7, 3],
              [0, 7, 4],
              [0, 7, 5],
              [0, 7, 6],
              [0, 7, 7],
              [0, 7, 8],
              [0, 7, 9],
              [0, 8, 0],
              [0, 8, 1],
              [0, 8, 2],
              [0, 8, 3],
              [0, 8, 4],
              [0, 8, 5],
              [0, 8, 6],
              [0, 8, 7],
              [0, 8, 8],
              [0, 8, 9],
              [0, 9, 0],
              [0, 9, 1],
              [0, 9, 2],
              [0, 9, 3],
              [0, 9, 4],
              [0, 9, 5],
              [0, 9, 6],
              [0, 9, 7],
              [0, 9, 8],
              [0, 9, 9],
              [1, 0, 1],
              [1, 0, 2],
              [1, 0, 3],
              [1, 0, 4],
              [1, 0, 5],
              [1, 0, 6],
              [1, 0, 7],
              [1, 0, 8],
              [1, 0, 9],
              [1, 1, 0],
              [1, 1, 1]
            ]
          )
      end
    end

    context 'when disc_count = 1 and reverse' do
      it 'works' do
        code_lock = CodeLock.new(1)
        cipher_finder = CipherFinder.new(from: [9], to: [6], exclude: [[0], [2]])

        expect(cipher_finder.call(code_lock: code_lock))
          .to eq(
            [
              [9],
              [8],
              [7],
              [6]
            ]
          )
      end
    end
  end

  describe 'not happy path' do
    context 'when wrong entry data' do
      it 'raises standard error' do
        code_lock = CodeLock.new(2)
        cipher_finder = CipherFinder.new(from: 9, to: 6, exclude: [[0], [2]])

        expect { cipher_finder.call(code_lock: code_lock) }.to raise_error StandardError
      end
    end

    context 'exclude contain final combination' do
      it 'returns no solution' do
        code_lock = CodeLock.new(3)
        cipher_finder = CipherFinder.new(from: [0, 0, 0], to: [1, 1, 3], exclude: [[1, 1, 3], [0, 0, 1]])

        expect(cipher_finder.call(code_lock: code_lock)).to eq('No solution')
      end
    end
  end
end
