module Textractor::Extractors

  class TextExtractor

    def text_from_path(path)
      File.read(path)
    end

  end

end
