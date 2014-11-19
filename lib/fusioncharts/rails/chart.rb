module Fusioncharts

    class Chart

      include ActionView::Helpers::OutputSafetyHelper

      attr_accessor :options

      def initialize(options=nil)
        self.options = options == nil ? {} : options
      end

      def setDimensions(width, height)
        self.setOption('width', width)
        self.setOption('height', height)

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

      def render
        config = self.options.to_json
        template = File.read(File.expand_path("../../../templates/chart.erb", __FILE__))
        renderer = ERB.new(template)
        raw renderer.result(binding)
      end

    end

end
