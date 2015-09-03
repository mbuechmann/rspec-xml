module RSpecXML
  module XMLMatchers
    class HaveXPath
      private

      class Matcher
        def initialize(options={})
          self.xpath = options[:xpath]
          self.example_group = options[:example_group]
          self.namespaces = options[:namespaces]
        end

        def matches?(xml)
          ::Nokogiri::XML(xml).xpath(full_xpath, namespaces).count > 0
        end

        def description
          "have xpath #{full_xpath}"
        end

        def failure_message
          "expected #{full_xpath} to exist"
        end

        def failure_message_when_negated
          "expected #{full_xpath} to not exist"
        end

        def full_xpath
          xpath_stack = example_group.instance_variable_get(:@xpath_stack) || []
          xpath_stack.join.concat(xpath)
        end

        attr_accessor :xpath, :example_group, :namespaces
      end
    end
  end
end
