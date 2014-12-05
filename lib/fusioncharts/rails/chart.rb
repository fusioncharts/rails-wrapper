module Fusioncharts

    class Chart

      include ::ActionView::Helpers::OutputSafetyHelper

      attr_accessor :options
      attr_reader :width, :height, :type, :renderAt, :dataSource, :dataFormat, :jsonUrl, :xmlUrl

      def initialize(options=nil)
        if options.nil?
          @options = {}
        else
          @options = options
          parse_options
        end
      end

      def width=(width)
        @width = width.to_s

        setOption('width', @width)
      end

      def height=(height)
        @height = height.to_s

        setOption('height', @height)
      end

      def type=(type)
        @type = type

        setOption('type', @type)
      end

      def dataFormat=(format)
        @dataFormat = format

        setOption('dataFormat', @dataFormat)
      end

      def renderAt=(id)
        @renderAt = id

        setOption('renderAt',  @renderAt)
      end
      
      def dataSource=(dataSource)
        @dataSource = dataSource

        setOption('dataSource', @dataSource)
      end

      def jsonUrl=(url)
        @jsonUrl = url
      end

      def xmlUrl=(url)
        @xmlUrl = url
      end

      def xmlUrl?
        self.xmlUrl ? true : false
      end

      def jsonUrl?
        self.jsonUrl ? true : false
      end

      def render
        config = self.options.to_json
        dataUrlFormat = self.jsonUrl? ? "json" : ( self.xmlUrl ? "xml" : nil )
        template = File.read(File.expand_path("../../../templates/chart.erb", __FILE__))
        renderer = ERB.new(template)
        raw renderer.result(binding)
      end

      private
      def setOption(key, value)
        self.options[key] = value

        return self
      end

      def parse_options
        keys = @options.keys

        keys.each{ |k| instance_variable_set "@#{k}".to_sym, @options[k] if self.respond_to? k }
      end

    end

end
