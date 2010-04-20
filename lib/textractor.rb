module Textractor
  autoload :Document, "textractor/document"

  def self.text_from_file(filename, options = {})
    Textractor::Document.new(filename, options).text
  end

  DEFAULT_WV_TEXT_PATH = File.expand_path(File.dirname(__FILE__) + "/../support/wvText.xml")

  def self.wvText_path
    @wvText_path || DEFAULT_WV_TEXT_PATH
  end

  def self.wvText_path=(path)
    @wvText_path = path
  end

end
