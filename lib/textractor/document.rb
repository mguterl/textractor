module Textractor

  class Document

    CONTENT_TYPE_CONVERSIONS = {
      'application/pdf'    => :pdf,
      'application/x-pdf'  => :pdf,
      'application/doc'    => :doc,
      'application/x-doc'  => :doc,
      'application/msword' => :doc,
      'text/plain'         => :txt,
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => :docx,
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
      when /docx/
        :docx
      when /doc/
        :doc
      when /txt/
        :txt
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

    def extract_from_doc
      `wvWare -c utf-8 --nographics -x #{Textractor.wvText_path} #{filename} 2>/dev/null`.strip
    end
    
    def extract_from_docx
      `#{File.dirname(__FILE__) + "/../../vendor/docx2txt/docx2txt.pl"} #{filename} -`.strip
    end

    def extract_from_txt
      File.read(filename)
    end

  end

end
