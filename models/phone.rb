# frozen_string_literal: true

module MyTelecom
  class Phone < ActiveRecord::Base
    PHONE_NUMBERS_OFFSET = 1_111_111_111
    PHONE_NUMBERS_LIMIT = 9_999_999_999

    def self.validate(number)
      (number <= PHONE_NUMBERS_LIMIT) && (number >= PHONE_NUMBERS_OFFSET)
    end

    def self.without_offset(number)
      number - PHONE_NUMBERS_OFFSET
    end

    def self.with_offset(number)
      PHONE_NUMBERS_OFFSET + number
    end
  end
end
