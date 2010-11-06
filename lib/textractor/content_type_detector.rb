module Textractor::ContentTypeDetector
  autoload :Simple,     'textractor/content_type_detector/simple'
  autoload :MimetypeFu, 'textractor/content_type_detector/mimetype_fu'
end

begin
  require 'rubygems'
  require 'yaml'
  require 'mimetype_fu'

  Textractor.content_type_detector = Textractor::ContentTypeDetector::MimetypeFu
rescue LoadError => e
  Textractor.content_type_detector = Textractor::ContentTypeDetector::Simple
end
