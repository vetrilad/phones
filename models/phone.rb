# frozen_string_literal: true

module MyTelecom
  class Phone < ActiveRecord::Base
    PHONE_NUMBERS_OFFSET = 1_111_111_111
    PHONE_NUMBERS_LIMIT = 9_999_999_999

    validates :phone_number_offset, uniqueness: true
    validates_numericality_of :phone_number_offset, greater_than_or_equal_to: 0
    validates_numericality_of :phone_number_offset, less_than_or_equal_to: PHONE_NUMBERS_LIMIT - PHONE_NUMBERS_OFFSET

    def self.without_offset(n)
      n - PHONE_NUMBERS_OFFSET
    end

    def self.with_offset(n)
      PHONE_NUMBERS_OFFSET + n
    end
  end
end
