module RSpecXML
  module XMLMatchers
    class HaveXPath

      private

      class TextMatcher

        def initialize(options={})
          self.xpath = options[:xpath]
          self.text = options[:text]
          self.namespaces = options[:namespaces]
        end

        def matches?(xml)
          ::Nokogiri::XML(xml).xpath(xpath, namespaces).to_a.any? { |e| e.text == text }
        end

        def description
          "have xpath #{xpath} with text #{text}"
        end

        def failure_message
          "expected #{xpath} to contain #{text}"
        end

        def failure_message_when_negated
          "expected #{xpath} to not exist with text: #{text}"
        end

        private

        attr_accessor :text, :xpath, :namespaces
      end
    end
  end
end
