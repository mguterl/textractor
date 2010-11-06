module Textractor::Extractors

  class DocExtractor

    DEFAULT_WV_TEXT_PATH = File.expand_path(File.dirname(__FILE__) + "/../../../support/wvText.xml").freeze

    class << self
      attr_writer :wvText_path

      def wvText_path
        @wvText_path || DEFAULT_WV_TEXT_PATH
      end
    end

    def text_from_path(path)
      command = "wvWare -c utf-8 --nographics -x #{wvText_path} #{path}"
      puts command if $DEBUG
      `#{command}`.strip
    end

    private

    def wvText_path
      self.class.wvText_path
    end

  end

end
