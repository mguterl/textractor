begin
  require 'rubygems'
  require 'yaml'
  require 'mimetype_fu'

  Textractor.content_type_detector = Textractor::MimetypeFuContentTypeDetector
rescue LoadError => e
  Textractor.content_type_detector = Textractor::SimpleContentTypeDetector
end
