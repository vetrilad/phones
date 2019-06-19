# frozen_string_literal: true

require_relative '../models/phone'

module MyTelecom
  class ListManager
    def initialize(list)
      @numbers = list.sort
    end

    def allot_number
      @numbers.each_with_index do |val, index|
        return index + 1 if (val + 1) != @numbers[index + 1]
      end
      0
    end

    def allot_custom_number(index)
      return index unless @numbers.include?(index)

      allot_number
    end
  end
end
