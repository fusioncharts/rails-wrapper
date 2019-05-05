require 'json'
require 'open-uri'

class PlottingTwoVariable
    def self.getChart
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/plotting-two-variable-measures-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/plotting-two-variable-measures-schema.json') { |f| f.read }
		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
							text: 'Cariaco Basin Sampling'
						  }")

		timeSeries.AddAttribute("subcaption", "{ 
										text: 'Analysis of O₂ Concentration and Surface Temperature'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
												plot: [{
												  value: 'O2 concentration',
												  connectNullData: true
												}],
												min: '3',
												max: '6',
												title: 'O₂ Concentration (mg/L)'  
											  }, {
												plot: [{
												  value: 'Surface Temperature',
												  connectNullData: true
												}],
												min: '18',
												max: '30',
												title: 'Surface Temperature (°C)'
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