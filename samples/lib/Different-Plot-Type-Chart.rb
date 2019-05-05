require 'json'
require 'open-uri'

class DifferentPlotTypeChart
    def self.getChart
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/different-plot-type-for-each-variable-measure-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/different-plot-type-for-each-variable-measure-schema.json') { |f| f.read }
				
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		
		timeSeries.AddAttribute("caption", "{ 
									text: 'Sales Performance'
								  }")

		timeSeries.AddAttribute("yAxis", "[{
										  plot: {
											value: 'Sale Amount',
											type: 'area'
										  },
										  title: 'Sale Amount',
										  format: {
											prefix: '$'
										  }
										}, {
										  plot: {
											value: 'Units Sold',
											type: 'column'
										  },
										  title: 'Units Sold'
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