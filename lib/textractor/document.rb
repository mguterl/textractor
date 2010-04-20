module Textractor

  class Document

    CONTENT_TYPE_CONVERSIONS = {
      'application/pdf'   => :pdf,
      'application/x-pdf' => :pdf,
      'application/doc'   => :word,
      'application/x-doc' => :word,
    }

    attr_reader :filename

    def initialize(filename, options = {})
      @filename = File.expand_path(filename)
      @content_type = options[:content_type]
    end

    def text
      send("extract_from_#{type}")
    end

    def type
      return CONTENT_TYPE_CONVERSIONS[content_type] if content_type
      case File.extname(@filename)
      when /pdf/
        :pdf
      when /doc/
        :word
      else
        nil
      end
    end

    private

    def content_type
      @content_type
    end

    def extract_from_pdf
      `pdftotext #{filename} - 2>/dev/null`.strip
    end

    def extract_from_word
      `wvWare -c utf-8 --nographics -x #{Textractor.wvText_path} #{filename} 2>/dev/null`.strip
    end

  end

end
