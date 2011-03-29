module Textractor::Extractors

  class PDFExtractor

    def text_from_path(path)
      `pdftotext '#{path}' - 2>/dev/null`.strip
    end

  end

end
