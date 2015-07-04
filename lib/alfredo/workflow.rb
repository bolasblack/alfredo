module Alfredo
  class Workflow
    attr_accessor :items

    def initialize
      @items = []
    end

    def <<(item)
      @items << item if item.is_a? Alfredo::Item
    end

    alias_method :add, :<<

    def to_xml
      items_elem = REXML::Element.new 'items'
      @items.each { |item| items_elem.elements << item.build_xml }
      items_elem.to_s
    end

    def output!
      puts to_xml
    end
  end
end
