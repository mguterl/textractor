require 'spec/spec_helper'

describe Textractor::Document do

  PDF_DOCUMENT_FIXTURE  = File.expand_path(File.dirname(__FILE__) + "/fixtures/document.pdf")
  WORD_DOCUMENT_FIXTURE = File.expand_path(File.dirname(__FILE__) + "/fixtures/document.doc")

  it 'should require a filename to create' do
    expect { Textractor::Document.new }.to raise_error(ArgumentError)
    Textractor::Document.new('filename').filename.should == File.expand_path('filename')
  end

  describe "#text" do

    describe "with pdf document" do

      it 'should extract the text from the document' do
        @doc = Textractor::Document.new(PDF_DOCUMENT_FIXTURE)
        @doc.text.should == "Ruby on rails developer"
      end

    end

    describe "with word document" do

      it 'should extract the text from the document' do
        @doc = Textractor::Document.new(WORD_DOCUMENT_FIXTURE)
        @doc.text.should == "Ruby on rails developer"
      end

    end

  end

  describe "#type" do

    describe "with no content type provided" do
      it 'should return :pdf for PDF documents' do
        @doc = Textractor::Document.new(PDF_DOCUMENT_FIXTURE)
        @doc.type.should == :pdf
      end

      it 'should return :word for Word documents' do
        @doc = Textractor::Document.new(WORD_DOCUMENT_FIXTURE)
        @doc.type.should == :word
      end

      it 'should return nil for unknown documents' do
        @doc = Textractor::Document.new("foo.bar")
        @doc.type.should == nil
      end
    end

    describe "with a content type provided" do

      it 'should ignore the extension of the file' do
        [PDF_DOCUMENT_FIXTURE, WORD_DOCUMENT_FIXTURE].each do |filename|
          Textractor::Document::CONTENT_TYPE_CONVERSIONS.each do |content_type, type|
            @doc = Textractor::Document.new(filename, :content_type => content_type)
            @doc.type.should == type
          end
        end
      end

    end

  end

end
