require 'json'
require 'open-uri'

class LineChartWithTimeAxis
    def self.getChart	
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/line-chart-with-time-axis-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/line-chart-with-time-axis-schema.json') { |f| f.read }

		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
												text: 'Sales Analysis'
											  }")

		timeSeries.AddAttribute("subcaption", "{ 
										text: 'Grocery'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: {
												value: 'Grocery Sales Value',
												type: 'line'
											  },
											  format: {
												prefix: '$'
											  },
											  title: 'Sale Value'
										   }]")		  
					
		
		# Create and return the chart object
		return Fusioncharts::Chart.new({
				width: "700",
				height: "450",
				type: "timeseries",
				renderAt: "chartContainer",
				dataFormat: 'json',
				timeSeries: timeSeries
			})
    end
end