require 'spec/spec_helper'

class TestExtractor

  def text_from_path(path)
    path
  end

end

describe Textractor do

  before do
    Textractor.clear_registry
  end

  describe ".text_from_path" do
    before do
      File.stub(:exists?).and_return(true)
      Textractor.stub(:content_type_for_path).and_return('test')
      Textractor.stub(:extractor_for_content_type).and_return(TestExtractor)
    end

    it 'extracts the text from a given path' do
      Textractor.text_from_path('document').should == 'document'
    end

    it 'uses content_type_for_path to determine the content type' do
      Textractor.should_receive(:content_type_for_path).with('document')
      Textractor.text_from_path('document')
    end

    it 'uses extractor_for_content_type to look up the correct extractor' do
      Textractor.should_receive(:extractor_for_content_type).with('test')
      Textractor.text_from_path('document')
    end

  end

  describe ".register_content_type" do

    it 'raises an exception if an extractor is already defined for that content type' do
      Textractor.register_content_type("text/plain", TestExtractor)

      expect {
        Textractor.register_content_type("text/plain", TestExtractor)
      }.to raise_error(Textractor::ContentTypeAlreadyRegistered)
    end

  end

  describe ".extractor_for_content_type" do
    before do
      Textractor.register_content_type("text/plain", TestExtractor)
    end

    it 'returns the extractor for the content type' do
      Textractor.extractor_for_content_type("text/plain").should == TestExtractor
    end

    it 'raises an exception when no extractor is defined for that content type' do
      expect {
        Textractor.extractor_for_content_type("unknown")
      }.to raise_error(Textractor::ContentTypeNotRegistered)
    end
  end

  describe ".content_type_for_path" do

    it 'returns the content type based on the file extension' do
      Textractor.content_type_for_path("document.pdf").should == "application/pdf"
    end

    it 'raises an exception if it cannot determine the content type' do
      expect {
        Textractor.content_type_for_path('unknown')
      }.to raise_error(Textractor::UnknownContentType)
    end

  end

  describe ".clear_registry" do
    before do
      Textractor.register_content_type("text/plain", TestExtractor)
    end

    it 'clears the registered content types and their respective extractors' do
      Textractor.clear_registry
      Textractor.extractors.should be_empty
    end

  end

end
