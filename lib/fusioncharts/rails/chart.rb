module Fusioncharts

    class Chart

      include ActionView::Helpers::OutputSafetyHelper

      attr_accessor :options, :jsonUrl, :xmlUrl

      def initialize(options=nil)
        self.options = options == nil ? {} : options
      end

      def setWidth(width)
        self.setOption('width', width.to_s)
 
        return self       
      end

      def setHeight(height)
        self.setOption('height', height.to_s)
        
        return self
      end

      def setChartType(type)
        self.setOption('type', type)

        return self
      end

      def setDataFormat(format)
        self.setOption('dataFormat', format)

        return self
      end

      def renderAt(id)
        self.setOption('renderAt',  id)

        return self
      end

      def setOption(key, value)
        self.options[key] = value

        return self
      end

      def setDataSource(dataSource)
        self.setOption('dataSource', dataSource)

        return self
      end

      def setJSONUrl(url)
        self.jsonUrl = url

        return self
      end

      def setXMLUrl(url)
        self.xmlUrl = url

        return self
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

    end

end
