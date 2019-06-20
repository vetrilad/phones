# frozen_string_literal: true

require_relative '../models/phone'

module MyTelecom
  class ListManager
    def initialize(list)
      @numbers = list.sort
    end

    def allot_number
      return 0 if @numbers == []

      @numbers.each_with_index do |val, index|
        return 0 if val != 0 && !@numbers[index + 1]
        return index + 1 if (val + 1) != @numbers[index + 1]
      end
    end

    def allot_custom_number(index)
      return index unless @numbers.include?(index)

      allot_number
    end
  end
end
