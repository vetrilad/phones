# frozen_string_literal: true

module MyTelecom
  class ListOperator
    def initialize(list)
      @list = sanetize(list)
    end

    def allot_number
      return 0 if @list == []

      @list.each_with_index do |val, index|
        return 0 if val && val != 0 && index < 1
        return index + 1 if (val + 1) != @list[index + 1]
      end
    end

    def allot_custom_number(index)
      return index unless @list.include?(index)

      allot_number
    end

    private

    def sanetize(list)
      list.sort
    end
  end
end
