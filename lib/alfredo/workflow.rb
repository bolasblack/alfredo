module Alfredo
  class Workflow
    attr_accessor :items
    attr_reader :info_plist

    def initialize
      @items = []
      @info_plist = Plist::parse_xml 'info.plist'
    end

    def << item
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

    def cache_path
      "#{ENV['HOME']}/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/#{info_plist['bundleid']}/"
    end

    def storage_path
      "#{ENV['HOME']}/Library/Application Support/Alfred 2/Workflow Data/#{info_plist['bundleid']}/"
    end
  end
end
