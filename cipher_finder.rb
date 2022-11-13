# frozen_string_literal: true

class CipherFinder
  attr_reader :from, :to, :exclude

  def initialize(from:, to:, exclude:)
    @from = from
    @to = to
    @exclude = exclude
  end

  def call(code_lock:)
    return 'No solution' if exclude.map { |combination| combination == to }.include?(true)

    possible_combinations = fetch_combinations(code_lock)

    return 'No solution' if possible_combinations.empty?

    result = []
    possible_combinations.each do |combination|
      result << combination
      break if combination == to
    end

    result
  rescue StandardError => e
    raise e
  end

  private

  def fetch_combinations(code_lock)
    from_num = from.join.to_i
    to_num = to.join.to_i

    possible_combinations =
      if from_num < to_num
        code_lock.all_possible_combinations.reject do |combination|
          combination_num = combination.join.to_i
          combination_num < from_num || combination_num > to_num
        end
      else
        code_lock.all_possible_combinations.reverse.reject do |combination|
          combination_num = combination.join.to_i
          combination_num > from_num || combination_num < to_num
        end
      end
    possible_combinations -= exclude

    possible_combinations
  end
end
