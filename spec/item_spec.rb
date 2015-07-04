require 'spec_helper'
include REXML

describe 'Alfredo::Item' do
  describe '#build_xml' do
    before do
      @item = Alfredo::Item.new(:title => 'foo',
                                :subtitle => 'bar',
                                :arg => 'baz',
                                :uid => 123,
                                :icon_path => 'icon.png',
                                :icon_type => 'fileicon',
                                :type => 'file',
                                :autocomplete => 'moo')

      @xml = @item.build_xml
    end

    describe 'attributes' do
      it 'should set uid' do
        @xml.attributes['uid'].should eq '123'
      end

      it 'should set uid to title when uid not set' do
        @item.uid = nil
        @item.build_xml.attributes['uid'].should eq @item.title
      end

      it 'should set type only when its file' do
        @xml.attributes['type'].should eq 'file'
      end

      it 'should not set type when its invalid' do
        @item.type = 'foo'
        @item.build_xml.attributes['type'].should be_nil
      end

      it 'should set valid to yes by default' do
        @xml.attributes['valid'].should eq 'yes'
      end

      it 'should set valid to no if its false' do
        @item.valid = false
        @item.build_xml.attributes['valid'].should eq 'no'
      end

      it 'should set autocomplete' do
        @xml.attributes['autocomplete'].should eq 'moo'
      end
    end

    describe 'child node' do
      it 'should set title' do
        @xml.elements['title'].text.should eq 'foo'
      end

      it 'should set subtitle' do
        @xml.elements['subtitle'].text.should eq 'bar'
      end

      it 'should set arg' do
        @xml.elements['arg'].text.should eq 'baz'
      end

      it 'should set icon to icon_path' do
        @item.build_xml.elements['icon'].text.should eq 'icon.png'
      end

      it 'should not set icon when no icon_path not present' do
        @item.icon_path = nil
        @item.build_xml.elements['icon'].should be_nil
      end

      it 'should set icon to icon_path without icon_type' do
        @item.icon_type = nil
        @item.build_xml.elements['icon'].text.should eq 'icon.png'
        @item.build_xml.elements['icon'].attributes['type'].should be_nil
      end

      it 'should set icon_type for fileicon' do
        @item.build_xml.elements['icon'].attributes['type'].should eq 'fileicon'
      end

      it 'should set icon_type for filetype' do
        @item.icon_type = 'filetype'
        @item.build_xml.elements['icon'].attributes['type'].should eq 'filetype'
      end

      it 'should not set icon_type when invalid' do
        @item.icon_type = nil
        @item.build_xml.elements['icon'].attributes['type'].should be_nil
      end
    end
  end
end
