# frozen_string_literal: true

class MaxSubArrayService
  def initialize(array)
    @input_array = array
  end

  def process
    maximum = SubArrayService.new
    current = SubArrayService.new

    [*0...@input_array.size].each do |index|
      current.sum = current.sum + @input_array[index]

      if current.sum > maximum.sum
        maximum.sum = current.sum
        current.set_bounds(current.start, index)
        maximum.set_bounds(current.start, index)
      elsif current.sum.negative?
        current.sum = 0
        current.set_bounds(index + 1, index + 1)
      end
    end

    @input_array.slice(maximum.start, maximum.end - maximum.start + 1)
  end
end
