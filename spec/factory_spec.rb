require 'spec_helper'
require 'factory.rb'

describe 'Factory' do

  let(:inner_class) { 'MyOwnClass' }
  let(:class_instance) { TestClass.new('One', 'Two', 'Three') }

  before(:all) do
    Factory.new('MyOwnClass', :l)
    TestClass = Factory.new(:a, :b, :c)
  end

  context '.new' do
    it 'should be in Factory constants' do
      constants = Factory.constants
      expect(constants.include?(:"#{inner_class}")).to be true
    end

    it 'should be in Module constants' do
      expect(Module.constants.include?(:TestClass)).to be true
    end

    context 'checking test_class methods creation' do
      it { expect(Factory::MyOwnClass.new('l method').l).to eq 'l method' }
      it { expect(class_instance.a).to eq 'One' }
    end


  end

  context '#[]' do
    it "when call 'a' with string" do
      expect(class_instance['a']).to eq 'One'
    end
    it "when call '1'" do
      expect(class_instance[1]).to eq 'Two'
    end
    it "when call ':c'" do
      expect(class_instance[:c]).to eq 'Three'
    end
  end

  context '#[]=' do
    it 'when assign [:a] = 2' do
      class_instance[:a] = 2
      expect(class_instance[:a]).to eq 2
    end

    it "when assign ['b'] = 3" do
      class_instance['b'] = 3
      expect(class_instance['b']).to eq 3
    end

    it 'when assign [2] = 4' do
      class_instance[2] = 4
      expect(class_instance[:c]).to eq 4
    end
  end

  context '#to_a' do
    it 'when call to_a' do
      expect(class_instance.to_a).to eq ['One', 'Two', 'Three']
    end
  end

  context '#to_h' do
    it 'when call to_h' do
      h = {a: 'One', b: 'Two', c: 'Three'}
      expect(class_instance.to_h).to eq h
    end
  end

  context '#length and #size' do
    it 'length equals 3' do
      expect(class_instance.length).to eq 3
    end
    it 'size equals 3' do
      expect(class_instance.size).to eq 3
    end
  end
end
