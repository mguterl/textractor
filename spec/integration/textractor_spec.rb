require 'spec_helper'

describe Textractor do

  before do
    Textractor.clear_registry
    Textractor.register_basic_types
  end

  it 'returns the contents of word (.doc) documents' do
    Textractor.text_from_path(fixture_path("document.doc")).should == 'text'
  end

  it 'returns the contents of word (.docx) documents' do
    Textractor.text_from_path(fixture_path("document.docx")).should == 'text'
  end

  it 'returns the contents of pdf documents' do
    Textractor.text_from_path(fixture_path("document.pdf")).should == 'text'
  end

  it 'returns the contents of text documents' do
    Textractor.text_from_path(fixture_path("document.txt")).should == 'text'
  end

  it 'allows the user to specify content type to avoid internal resolution' do
    Textractor.text_from_path(fixture_path("no_extension"), :content_type => "application/pdf").should == 'text'
  end

  it 'raises an exception when the content type is unable to be determined' do
    expect {
      Textractor.text_from_path(fixture_path("no_extension"))
    }.to raise_error(Textractor::UnknownContentType)
  end

  it 'raises an exception when the path specified does not exist' do
    expect {
      Textractor.text_from_path('non-existant')
    }.to raise_error(Textractor::FileNotFound)
  end

  it 'raises an exception when there is no extractor defined for the content type' do
    Textractor.clear_registry

    expect {
      Textractor.text_from_path(fixture_path('document.pdf'))
    }.to raise_error(Textractor::ContentTypeNotRegistered)
  end

  it 'allows content type extractors to be removed' do
    Textractor.remove_content_type("application/pdf")

    expect {
      Textractor.text_from_path(fixture_path('document.pdf'))
    }.to raise_error(Textractor::ContentTypeNotRegistered)
  end

  it 'returns the contents of doc files with a space in the path' do
    Textractor.text_from_path(fixture_path("document .doc")).should == 'text'
  end

  it 'returns the contents of docx files with a double quote  in the path' do
    Textractor.text_from_path(fixture_path("document\".docx")).should == 'text'
  end

  it 'returns the contents of pdf files with a single quote in the path' do
    Textractor.text_from_path(fixture_path("document'.pdf")).should == 'text'
  end

  it 'returns the contents of txt files with a space in the path' do
    Textractor.text_from_path(fixture_path("document .txt")).should == 'text'
  end

end
