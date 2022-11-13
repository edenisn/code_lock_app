# frozen_string_literal: true

class CodeLock
  DIGITALS = (0..9).to_a.freeze

  attr_accessor :disc_count
  attr_reader :all_possible_combinations

  def initialize(disc_count)
    @disc_count = disc_count
    @all_possible_combinations = DIGITALS.repeated_permutation(@disc_count).to_a
  end
end
