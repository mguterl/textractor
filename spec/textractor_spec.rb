require 'spec/spec_helper'

describe Textractor do

  describe ".wvText_path" do

    it 'should default to the file provided with the gem' do
      Textractor.wvText_path.should == Textractor::DEFAULT_WV_TEXT_PATH
    end

    it 'should use the new wvText_path if provided' do
      Textractor.wvText_path = "foo.bar"
      Textractor.wvText_path.should == "foo.bar"
    end

  end

  describe ".text_from_file" do

    it 'should return the extracted text from the file' do
      document_path = 'word.doc'
      document = mock("Textractor::Document", :text => "Ruby on Rails developer")
      Textractor::Document.should_receive(:new).with(document_path, :content_type => "application/doc").and_return(document)
      Textractor.text_from_file(document_path, :content_type => "application/doc").should == "Ruby on Rails developer"
    end

  end

  after(:all) do
    Textractor.instance_variable_set(:"@wvText_path", nil)
  end
end
