# frozen_string_literal: true

class SubArrayService
  attr_accessor :sum
  attr_reader :start, :end

  def initialize
    @start = 0
    @end = 0
    @sum = 0
  end

  def set_bounds(list_start, list_end)
    @start = list_start
    @end = list_end
  end
end
