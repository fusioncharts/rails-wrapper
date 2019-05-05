require 'json'
require 'open-uri'

class DateRangeEventOverlay
    def self.getChart
	
		data = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/date-range-event-overlay-data.json') { |f| f.read }
		schema = open('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/date-range-event-overlay-schema.json') { |f| f.read }
		
		
		fusionTable = Fusioncharts::FusionTable.new(schema, data)
		timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

		timeSeries.AddAttribute("caption", "{ 
							text: 'Interest Rate Analysis'
						  }")

		timeSeries.AddAttribute("subCaption", "{ 
										text: 'Federal Reserve (USA)'
									  }")

		timeSeries.AddAttribute("yAxis", "[{
											  plot: 'Interest Rate',
											  format:{
												suffix: '%'
											  },
											  title: 'Interest Rate'
											}]")

		timeSeries.AddAttribute("xAxis", "{
										  plot: 'Time',
										  timemarker: [{
											start: 'Jul-1981',
											end: 'Nov-1982',
											label: 'Economic downturn was triggered by {br} tight monetary policy in an effort to {br} fight mounting inflation.',
											timeFormat: '%b-%Y'
										  }, {
											start: 'Jul-1990',
											end: 'Mar-1991',
											label: 'This eight month recession period {br} was characterized by a sluggish employment recovery, {br} most commonly referred to as a jobless recovery.',
											timeFormat: '%b-%Y'
										  }, {
											start: 'Jun-2004',
											end: 'Jul-2006',
											label: 'The Fed after raising interest rates {br} at 17 consecutive meetings, ends its campaign {br} to slow the economy and forestall inflation.',
											timeFormat: '%b-%Y'
										  }, {
											start: 'Dec-2007',
											end: 'Jun-2009',
											label: 'Recession caused by the worst {br} collapse of financial system in recent {br} times.',
											timeFormat: '%b-%Y'
										  }]
										}")	  
					
		
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