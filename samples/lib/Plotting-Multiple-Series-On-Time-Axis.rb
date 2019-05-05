require 'json'
require 'open-uri'

class PlottingMultipleSeriesOnTimeAxis
    def self.getChart	
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/plotting-multiple-series-on-time-axis-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/plotting-multiple-series-on-time-axis-schema.json') { |f| f.read }

		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
											text: 'Sales Analysis'
										  }")

		timeSeries.AddAttribute("subcaption", "{ 
										text: 'Grocery & Footwear'
									  }")
									  
		timeSeries.AddAttribute("series", "'Type'")

		timeSeries.AddAttribute("yAxis", " [{
											  plot: 'Sales Value',
											  title: 'Sale Value',
											  format: {
												prefix: '$'
											  }
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