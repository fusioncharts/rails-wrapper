require 'fusioncharts-rails'

require 'first_chart'
require 'first_widget'
require 'first_map'
require 'drilldown'
require 'angular_gauge'
require 'mscolumn2d'

require 'Line-Chart-With-Time-Axis'
require 'Plotting-Multiple-Series-On-Time-Axis'
require 'Column-and-line-combination-on-time-axis'
require 'Plotting-Two-Variables'
require 'Different-Plot-Type-Chart'
require 'ColumnChart-With-Time-Axis'
require 'AreaChart-With-Time-Axis'
require 'Interactive-candlestick-chart'
require 'Annotating-single-data-point'
require 'Single-Event-Overlay'
require 'Date-range-event-overlay'
require 'Adding-Reference-Line'

require 'drill_down_data_handler'

class SamplesController < ApplicationController
  protect_from_forgery except: :handler
  def index

    ##### Variables for First Chart Sample
		@first_chart=FirstChart.getChart
		@first_widget=FirstWidget.getWidget
		@first_map=FirstMap.getMap

    @drilldown_chart = Drilldown.getChart
    
    @myGauge = AngularGuage.getGauge

    @myMsColumn2dChart = Mscolumn2d.getChart
	
	@myLineChartWithTimeAxis = LineChartWithTimeAxis.getChart
	@myPlottingMultipleSeriesOnTimeAxis = PlottingMultipleSeriesOnTimeAxis.getChart
	@myColumnLineCombinationData = ColumnLineCombinationData.getChart
	@myPlottingTwoVariable = PlottingTwoVariable.getChart
	@myDifferentPlotTypeChart = DifferentPlotTypeChart.getChart
	@myColumnChartWithTimeAxis = ColumnChartWithTimeAxis.getChart
	@myAreaChartWithTimeAxis = AreaChartWithTimeAxis.getChart
	@myCandlestickChart = CandlestickChart.getChart
	@myAnnotatingSingleDataPoint = AnnotatingSingleDataPoint.getChart
	@mySingleEventOverlay = SingleEventOverlay.getChart
	@myDateRangeEventOverlay = DateRangeEventOverlay.getChart
	@myAddingReferenceLine = AddingReferenceLine.getChart

		render template: "/samples/#{params[:page]}"

  end
  
  def home
    redirect_to "/samples/index"
  end

  def handler
    # render json: {"test"=>"test-data"}
    render json: DrillDownDataHandler.getData(params)
    # render json: DrillDownDataHandler.getChart(params)
  end

end
