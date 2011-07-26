require 'spec_helper'

describe Textractor::ContentTypeDetector::Simple do

  FILENAMES = [
    [
      "foo.pdf", "application/pdf",
      "foo.doc", "application/msword",
      "foo.docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "foo.txt", "text/plain",
    ]
  ]

  describe '.content_type_for_path' do
    FILENAMES.each do |(filename, content_type)|
      context "given #{filename}" do
        it "returns #{content_type}" do
          Textractor::ContentTypeDetector::Simple.content_type_for_path(filename).should == content_type
        end
      end

      context "given #{filename}" do
        it "returns #{content_type}" do
          Textractor::ContentTypeDetector::Simple.content_type_for_path(filename.upcase).should == content_type
        end
      end
    end
  end

end
