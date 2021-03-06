module Textractor::ContentTypeDetector

  class Simple

    def self.content_type_for_path(path)
      case File.extname(path.downcase)
      when /\.pdf$/
        'application/pdf'
      when /\.doc$/
        'application/msword'
      when /\.docx$/
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      when /\.txt$/
        'text/plain'
      end
    end

  end

end
