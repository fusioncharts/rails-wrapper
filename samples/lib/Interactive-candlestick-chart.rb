require 'json'
require 'open-uri'

class CandlestickChart
    def self.getChart
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/candlestick-chart-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/candlestick-chart-schema.json') { |f| f.read }
		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
										text: 'Apple Inc. Stock Price'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: {
												value: {
												  open: 'Open',
												  high: 'High',
												  low: 'Low',
												  close: 'Close'
												},
												type: 'candlestick'
											  },
											  format: {
												prefix: '$'
											  },
											  title: 'Stock Value'
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