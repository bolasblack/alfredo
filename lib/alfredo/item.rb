module Alfredo
  class Item
    attr_accessor :title, :subtitle, :autocomplete, :arg, :valid, :uid, :type, :icon_path, :icon_type

    def initialize(attributes = {})
      attributes.each do |attribute,value|
        send("#{attribute}=", value) if respond_to? "#{attribute}="
      end
    end

    def uid
      @uid || title
    end

    def icon_type
      @icon_type if %w{fileicon filetype}.include? @icon_type
    end

    def valid
      if @valid == false
        'no'
      else
        'yes'
      end
    end

    def autocomplete
      @autocomplete || title
    end

    def type
      @type if @type == 'file'
    end

    def build_xml
      item_elem = REXML::Element.new 'item'

      %w{uid valid autocomplete type}.each do |attrName|
        item_elem.attributes[attrName] = send attrName
      end

      %w{title subtitle arg}.each do |subtagName|
        subtag = REXML::Element.new subtagName, item_elem
        subtag.text = send subtagName
      end

      if icon_path
        icon_elem = REXML::Element.new 'icon', item_elem
        icon_elem.attributes['type'] = icon_type
        icon_elem.text = icon_path
      end

      item_elem
    end
  end
end
