require 'json'
require 'open-uri'

class ColumnLineCombinationData
    def self.getChart
	
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/column-line-combination-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/column-line-combination-schema.json') { |f| f.read }		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
									text: 'Web visits & downloads'
								  }")

		timeSeries.AddAttribute("subcaption", "{ 
										text: 'since 2015'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: [{
													value: 'Downloads',
													type: 'column'
												  }, {
													value: 'Web Visits',
													type: 'line'
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