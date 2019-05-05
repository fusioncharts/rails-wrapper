module Fusioncharts

    class Chart

      include ::ActionView::Helpers::OutputSafetyHelper

      attr_accessor :options, :fusionchartsEvent, :timeSeriesData, :timeSeriesSource
      attr_reader :width, :height, :type, :renderAt, :dataSource, :dataFormat, :jsonUrl, :xmlUrl, :timeSeries

      # Constructor
      def initialize(options=nil)
        @fusionchartsEvent = ""
		@timeSeriesData = ""
		@timeSeriesSource = nil
        if options.nil?
          @options = {}
        else
          @options = options
          parse_options
        end
      end

      # Sets the width for a chart
      def width=(width)
        @width = width.to_s

        setOption('width', @width)
      end

      # Sets the height for a chart
      def height=(height)
        @height = height.to_s

        setOption('height', @height)
      end

      # Set the type for a chart
      def type=(type)
        @type = type

        setOption('type', @type)
      end

      # Sets the dataformat for a chart.
      # Valid values are: json / xml
      def dataFormat=(format)
        @dataFormat = format

        setOption('dataFormat', @dataFormat)
      end

      # Set the DOM id where the chart needs to be rendered
      def renderAt=(id)
        @renderAt = id

        setOption('renderAt',  @renderAt)
      end
      
      # Set the datasource for the chart. It can take the following formats
      # 1. Ruby Hash
      # 2. XML string
      # 3. JSON string
      def dataSource=(dataSource)
        @dataSource = dataSource
        parse_datasource_json
      end
	  
      # Set the datasource for the chart. It can take the following formats
      # 1. Ruby Hash
      # 2. XML string
      # 3. JSON string
      def timeSeries=(timeSeries)
        @timeSeries = timeSeries
        #parse_datasource_json
      end	  

      # Set the JSON url where data needs to be loaded
      def jsonUrl=(url)
        @jsonUrl = url
      end

      # Set the XML url where data needs to be loaded
      def xmlUrl=(url)
        @xmlUrl = url
      end

      # Returns where the chart needs to load XML data from a url
      def xmlUrl?
        self.xmlUrl ? true : false
      end

      # Returns where the chart needs to load JSON data from a url
      def jsonUrl?
        self.jsonUrl ? true : false
      end
      
      def addEvent(eventName, eventHandler)
        @fusionchartsEvent << "\n_fc_chart.addEventListener(\"" << eventName << "\"," << eventHandler << ")\n";
      end

      # Render the chart
      def render
        config = json_escape JSON.generate(self.options)
		if @timeSeriesSource
			config.gsub! '"__DataSource__"', json_escape(@timeSeriesSource)
		end
        dataUrlFormat = self.jsonUrl? ? "json" : ( self.xmlUrl ? "xml" : nil )
        template = File.read(File.expand_path("../../../templates/chart.erb", __FILE__))
        renderer = ERB.new(template)
        return raw renderer.result(binding)
      end

      private
      # Helper method to add property to the options hash
      def setOption(key, value)
        self.options[key] = value

        return self
      end

      # Helper method to convert json string to Ruby hash
      def parse_datasource_json
        @dataFormat = "json" unless defined? @dataFormat

        if !xmlUrl? or !jsonUrl?
          @dataSource = JSON.parse(@dataSource) if @dataSource.is_a? String and @dataFormat == "json"
        end

        setOption('dataSource', @dataSource)
      end

      # Helper method that converts the constructor params into instance variables
      def parse_options
		newOptions = nil
		@options.each do |key, value|
			if key.downcase.to_s.eql? "timeseries"
				@timeSeriesData = value.GetDataStore()
				@timeSeriesSource = value.GetDataSource()
				newOptions = {}			
				newOptions['dataSource'] = "__DataSource__"
				@options.delete(key)
			end
		end
		if newOptions
			@options.merge!(newOptions)			
		end
		
        keys = @options.keys
        keys.each{ |k| instance_variable_set "@#{k}".to_sym, @options[k] if self.respond_to? k }
        #parse_datasource_json
      end

      # Escape tags in json, if avoided might be vulnerable to XSS
      def json_escape(str)
        str.to_s.gsub('/', '\/')
      end

    end
	
	class TimeSeries
	
		include ::ActionView::Helpers::OutputSafetyHelper
		attr_accessor :fusionTableObject, :attributesList

		# Constructor
		def initialize(fusionTable)	
			@fusionTableObject = fusionTable
			@attributesList = {}
		end
		
		def AddAttribute(key, value)
			temp_hash = {}
			temp_hash[key] = value		
			@attributesList.merge!(temp_hash);
        end
	
		def GetDataSource()
			stringData = ''			
			@attributesList.each do |key, value|
			  stringData += "%s:%s,\n" % [key, value]
			end			
			stringData += "%s:%s" % ['data', 'fusionTable']
			stringData = "{" + "\n" + stringData + "\n" + "}"
			return stringData.html_safe
		end
		
		def GetDataStore()
			return @fusionTableObject.GetDataTable()			
        end
	end
	
	class OrderBy
		ASC = 0, DESC = 1
	end
	
	class FilterType
		Equals = 0, Greater = 1, GreaterEquals = 2, Less = 3, LessEquals = 4, Between = 5
	end	
	
	class FusionTable
		
		include ::ActionView::Helpers::OutputSafetyHelper
		
		attr_accessor :stringData

		# Constructor
		def initialize(schema, data)
			@stringData = ""
			@stringData = "let schema = " + schema.to_s + ";\n"
            @stringData += "let data = " + data.to_s + ";\n"
            @stringData += "let fusionDataStore = new FusionCharts.DataStore();\n"
            @stringData += "let fusionTable = fusionDataStore.createDataTable(data, schema);\n"
		end	

        def Select(*columnName)		
			if columnName.count > 0
				selectData = ("'" + columnName.join("','") + "'")
				@stringData += "fusionTable = fusionTable.query(FusionCharts.DataStore.Operators.select([" + selectData + "]));" + "\n"
			end
        end
		
		def Sort(columnName, columnOrderBy)  
			sortData = "sort([{column: '%s', order: '%s'}])" % [columnName, (OrderBy::ASC === columnOrderBy) ? "asc" : "desc"]
            @stringData += "fusionTable = fusionTable.query(" + sortData + ");" + "\n"
        end
		
		def CreateFilter(filterType, columnName, *values)
			filterData = ""
			filterName = ""
			case filterType
				when FilterType::Equals
				  filterName = "equals"
				when FilterType::Greater
				  filterName = "greater"
				when FilterType::GreaterEquals
				  filterName = "greaterEquals"
				when FilterType::Less
				  filterName = "less"
				when FilterType::LessEquals
				  filterName = "lessEquals"
				when FilterType::Between
				  filterName = "between"				  
			end
						
			if filterName !=nil
				case filterType
					when FilterType::Equals
						filterData = "FusionCharts.DataStore.Operators.%s('%s','%s')" % [filterName, columnName, values[0]]
					when FilterType::Between
						if values.count > 1
							filterData = "FusionCharts.DataStore.Operators.%s('%s',%s,%s)" % [filterName, columnName, values[0], values[1]]
						end
					else
						filterData = "FusionCharts.DataStore.Operators.%s('%s',%s)" % [filterName, columnName, values[0]]
				end
            end
			
			return filterData
		end
		
		def ApplyFilter(filter)
            if filter !=nil
                @stringData += "fusionTable = fusionTable.query(" + filter + ");\n"
            end
        end
		
		def ApplyFilterByCondition(filter)
            if filter !=nil			
				filterQuery = "FusionCharts.DataStore.Operators.filter(" + filter +")"
                @stringData += "fusionTable = fusionTable.query(" + filterQuery + ");\n"
            end
        end
		
		def Pipe(*filters)
			if filters.count > 0
				filterData = filters.join(",")
                @stringData += "fusionTable = fusionTable.query(FusionCharts.DataStore.Operators.pipe(" + filterData + "));\n"
            end
        end
		
		def GetDataTable
			return @stringData.html_safe
		end
	end

end
