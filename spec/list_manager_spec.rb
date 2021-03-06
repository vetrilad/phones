# frozen_string_literal: true

describe MyTelecom::ListOperator do
  describe '#allot_any_possition' do
    it 'can allot a new possition when it is at the end of the list' do
      list_operator = MyTelecom::ListOperator.new([0])
      expect(list_operator.allot_number).to eq(1)
    end

    it 'can allot a new possition when there is a gap in the range' do
      list_operator = MyTelecom::ListOperator.new([0, 1, 2, 4, 5, 6, 7, 9])
      expect(list_operator.allot_number).to eq(3)
    end

    it 'can allot a new possition after a custom possition was inserted' do
      list_operator = MyTelecom::ListOperator.new([9])
      expect(list_operator.allot_number).to eq(0)
    end
  end

  describe '#allot_custom_possition' do
    it 'can allot a new custom possition' do
      list_operator = MyTelecom::ListOperator.new([0])
      expect(list_operator.allot_custom_number(5)).to eq(5)
    end

    it 'can allot a new possition when the custom possitoin is not available' do
      list_operator = MyTelecom::ListOperator.new([0, 1, 2, 4, 5, 6, 7, 9])
      expect(list_operator.allot_custom_number(5)).to eq(3)
    end
  end
end
