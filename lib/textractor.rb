module Textractor

  UnknownContentType           = Class.new(StandardError)
  FileNotFound                 = Class.new(StandardError)
  ContentTypeAlreadyRegistered = Class.new(StandardError)
  ContentTypeNotRegistered     = Class.new(StandardError)

  autoload :Extractors, "textractor/extractors"

  def self.text_from_path(path, options = {})
    raise FileNotFound unless File.exists?(path)
    content_type    = options.fetch(:content_type) { content_type_for_path(path) }
    extractor_class = extractor_for_content_type(content_type)
    extractor       = extractor_class.new

    extractor.text_from_path(path)
  end

  def self.content_type_for_path(path)
    case File.extname(path)
    when /\.pdf$/
      'application/pdf'
    when /\.doc$/
      'application/msword'
    when /\.docx$/
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    when /\.txt$/
      'text/plain'
    else
      raise UnknownContentType, "unable to determine content type for #{path}"
    end
  end

  def self.register_content_type(content_type, extractor)
    raise ContentTypeAlreadyRegistered, "#{content_type} is already registered" if extractors[content_type]
    extractors[content_type] = extractor
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
