# frozen_string_literal: true

module MyTelecom
  module OperatorServiceHelper
    FORMAT_ERROR = "Phone number should be between #{Phone::PHONE_NUMBERS_OFFSET} " \
            "and #{Phone::PHONE_NUMBERS_LIMIT}"

    def used_numbers
      Phone.all.map(&:phone_number_offset)
    end

    def allocate_phone_number(number = nil)
      if number
        base_number = Phone.without_offset(sanitize_phone_number(number))
        ListOperator.new(used_numbers).allot_custom_number(base_number)
      else
        ListOperator.new(used_numbers).allot_number
      end
    end

    def persist_phone_number(number)
      phone = Phone.new(phone_number_offset: number)
      halt(500, { error: FORMAT_ERROR }.to_json) unless phone.valid?
      phone.save
    end

    def present_phone_number(number)
      allocated_number = Phone.with_offset(number).to_s
      [3, 7].each { |i| allocated_number.insert i, '-' }
      { allocated_number: allocated_number }.to_json
    end

    def sanitize_phone_number(number)
      number.delete('-').to_i
    end
  end
end
