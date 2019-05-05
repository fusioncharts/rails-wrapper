require 'json'
require 'open-uri'

class ColumnChartWithTimeAxis
    def self.getChart
	
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/column-chart-with-time-axis-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/column-chart-with-time-axis-schema.json') { |f| f.read }
		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)
		
		timeSeries.AddAttribute("chart", "{ 
										showLegend: 0
									  }")

		timeSeries.AddAttribute("caption", "{ 
										text: 'Daily Visitors Count of a Website'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: {
												value: 'Daily Visitors',
												type: 'column'
												},
											  title: 'Daily Visitors (in thousand)'
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