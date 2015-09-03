require 'spec_helper'

module Factory
  def self.example_group
    @example_group ||= Class.new
  end
  def self.xpath_matcher(xpath, namespaces = {})
    RSpecXML::XMLMatchers::HaveXPath.new(xpath, namespaces, example_group)
  end
end

describe RSpecXML::XMLMatchers::HaveXPath do
  let(:example_group) { Factory.example_group }

  describe '#intialize' do
    it 'should build and save a matcher containing the supplied xpath and namespaces' do

      RSpecXML::XMLMatchers::HaveXPath::Matcher.
        expects(:new).
        with(:xpath => 'fake xpath', :namespaces => { :a => 'https://www.example.com/namespace' }, :example_group => example_group).
        returns(:flag)

      xpath_matcher = Factory.xpath_matcher('fake xpath', :a => 'https://www.example.com/namespace')
      expect(xpath_matcher.send(:matcher)).to eq :flag

    end
  end

  describe '#with_text' do
    it 'should build a new text matcher containing supplied xpath and text' do

      RSpecXML::XMLMatchers::HaveXPath::TextMatcher.
        expects(:new).
        with(:xpath => 'fake xpath', :text => 'blah', :namespaces => {}).
        returns(:flag)

      xpath_matcher = Factory.xpath_matcher('fake xpath').with_text('blah')
      expect(xpath_matcher.send(:matcher)).to eq :flag

    end
  end

  describe '#with_attr' do
    it 'should build a new attribute matcher containing supplied xpath and attributes' do

      RSpecXML::XMLMatchers::HaveXPath::AttrMatcher.
        expects(:new).
        with(:xpath => 'fake xpath', :attr => {"name" => "John Doe"}, :namespaces => {}).
        returns(:flag)

      xpath_matcher = Factory.xpath_matcher('fake xpath').with_attr({"name" => "John Doe"})
      expect(xpath_matcher.send(:matcher)).to eq :flag
    end
  end

  describe '#failure_message' do
    it 'should delegate to the matcher' do
      xpath_matcher = Factory.xpath_matcher('whatever')
      xpath_matcher.stubs(:matcher).returns(stub( :failure_message => 'woo!' ))
    end
  end

  describe '#failure_message_when_negated' do
    it 'should delegate to the matcher' do
      xpath_matcher = Factory.xpath_matcher('whatever')

      expect(xpath_matcher.failure_message_when_negated).to eq 'expected whatever to not exist'
    end
  end
end
