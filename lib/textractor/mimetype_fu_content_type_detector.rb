module Textractor

  class MimetypeFuContentTypeDetector

    def self.content_type_for_path(path)
      File.mime_type?(path)
    end

  end

end
