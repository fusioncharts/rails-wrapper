require 'json'
require 'open-uri'

class AddingReferenceLine
    def self.getChart
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/adding-a-reference-line-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/adding-a-reference-line-schema.json') { |f| f.read }		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
								text: 'Temperature readings in Italy'
							  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: 'Temperature',
											  title: 'Temperature',
											  format:{
												suffix: '°C',
											  },
											  referenceLine: [{
												label: 'Controlled Temperature',
												value: '10'
											  }]
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