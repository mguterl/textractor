module Textractor

  UnknownContentType           = Class.new(StandardError)
  FileNotFound                 = Class.new(StandardError)
  ContentTypeAlreadyRegistered = Class.new(StandardError)
  ContentTypeNotRegistered     = Class.new(StandardError)

  autoload :Extractors, 'textractor/extractors'

  def self.text_from_path(path, options = {})
    raise FileNotFound unless File.exists?(path)
    content_type    = options.fetch(:content_type) { content_type_for_path(path) }
    extractor       = extractor_for_content_type(content_type)

    if extractor.is_a?(Proc)
      extractor.call(path)
    else
      extractor.new.text_from_path(path)
    end
  end

  class << self
    attr_accessor :content_type_detector
  end

  def self.content_type_for_path(path)
    content_type_detector.content_type_for_path(path) or raise UnknownContentType, "unable to determine content type for #{path}"
  end

  def self.register_content_type(content_type, extractor = nil, &block)
    raise ContentTypeAlreadyRegistered, "#{content_type} is already registered" if extractors[content_type]
    if extractor
      extractors[content_type] = extractor
    elsif block_given?
      extractors[content_type] = block
    end
  end

  def self.remove_content_type(content_type)
    extractors.delete content_type
  end

  def self.extractor_for_content_type(content_type)
    extractors[content_type] or raise ContentTypeNotRegistered, "#{content_type} is not registered with Textractor"
  end

  def self.extractors
    @extractors ||= {}
  end

  def self.clear_registry
    @extractors = {}
  end

  def self.register_basic_types
    register_content_type("application/pdf", Extractors::PDFExtractor)
    register_content_type("application/msword", Extractors::DocExtractor)
    register_content_type("application/vnd.openxmlformats-officedocument.wordprocessingml.document", Extractors::DocxExtractor)
    register_content_type("text/plain", Extractors::TextExtractor)
  end

  register_basic_types

end

require 'textractor/content_type_detector'
require 'escape'
