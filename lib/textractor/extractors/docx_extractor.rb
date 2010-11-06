module Textractor::Extractors

  class DocxExtractor

    DEFAULT_DOCX2TXT_PATH = File.expand_path(File.dirname(__FILE__) + "/../../../vendor/docx2txt/docx2txt.pl").freeze

    class << self
      attr_writer :docx2txt_path

      def docx2txt_path
        @docx2txt_path || DEFAULT_DOCX2TXT_PATH
      end
    end


    def text_from_path(path)
      `#{docx2txt_path} #{path} -`.strip
    end

    private

    def docx2txt_path
      self.class.docx2txt_path
    end

  end

end
