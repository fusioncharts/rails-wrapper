describe Fusioncharts::Chart do
  
  before do
    @dataSource = {
      chart: {
        caption: "Comparison of Quarterly Revenue",
        subCaption: "Harry's SuperMart",
        xAxisname: "Quarter",
        yAxisName: "Amount ($)",
        numberPrefix: "$",
        theme: "fint",
        exportEnabled: "1",
        exportHandler: "/export",
        exportAction: "save"
      },
      categories: [{
            category: [
              { label: "Q1" },
              { label: "Q2" },
              { label: "Q3" },
              { label: "Q4" }
            ]
          }],
          dataset: [
            {
              seriesname: "Previous Year",
              data: [
                  { value: "10000" },
                  { value: "11500" },
                  { value: "12500" },
                  { value: "15000" }
              ]
            },
            {
              seriesname: "Current Year",
              data: [
                  { value: "25400" },
                  { value: "29800" },
                  { value: "21800" },
                  { value: "26800" }
              ]
            }
        ]
    }

    @options = {
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart",
      dataFormat: "json",
      dataSource: @dataSource
    }

    @options2 = {
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart",
      dataFormat: "json"
    }

    @options3 = {
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart",
      dataFormat: "json"
    }

    @options4 = {
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart",
      dataFormat: "xml"
    }

    @options5 = {
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart",
      dataFormat: "json"
    }

    @chart = Fusioncharts::Chart.new(@options)
    @chart2 = Fusioncharts::Chart.new(@options2)
    @chart3 = Fusioncharts::Chart.new(@options3)
    @chart4 = Fusioncharts::Chart.new(@options4)
    @chart5 = Fusioncharts::Chart.new(@options5)
  end

  it "should be an instance of Chart" do
    expect(@chart).to be_instance_of(Fusioncharts::Chart)
  end

  it "should initialize the options correctly" do
    options = @chart.instance_variable_get(:@options)

    expect(options).to eq(@options)
  end

  it "should set the width correctly" do
    @chart.width = 800

    expect(@chart.width).to eq("800")
  end

  it "should get the width correctly" do
    expect(@chart.width).to eq("600")
  end

  it "should set the height correctly" do
    @chart.height = 600

    expect(@chart.height).to eq("600")
  end

  it "should get the height correctly" do
    expect(@chart.height).to eq("400")
  end

  it "should set the chart type correctly" do
    @chart.type = "mscolumn3d"

    expect(@chart.type).to eq("mscolumn3d")
  end

  it "should get the correct chart type" do
    expect(@chart.type).to eq("mscolumn2d")
  end

  it "should set the dataFormat correctly" do
    @chart.dataFormat = "xml"

    expect(@chart.dataFormat).to eq("xml")
  end

  it "should get the dataFormat correctly" do
    expect(@chart.dataFormat).to eq("json")
  end

  it "should set renderAt correctly" do
    @chart.renderAt = "chart-component"

    expect(@chart.renderAt).to eq("chart-component")
  end

  it "should get renderAt correctly" do
    expect(@chart.renderAt).to eq("chart")
  end

  it "should set the datasource correctly" do
    @chart2.dataSource = @dataSource

    expect(@chart2.dataSource).to eq(@dataSource)
  end

  it "should get the dataSource correctly" do
    expect(@chart.dataSource).to eq(@dataSource)
  end

  it "should set the json url correctly" do
    @chart3.jsonUrl = "/data/chart.json"

    expect(@chart3.jsonUrl).to eq("/data/chart.json")
  end

  it "should set the xml url correctly" do
    @chart4.xmlUrl = "/data/chart.xml"

    expect(@chart4.xmlUrl).to eq("/data/chart.xml")
  end

  it "should return true for json url and false for xml url" do
    @chart4.jsonUrl = "/data/chart.json"

    expect(@chart4.jsonUrl?).to eq(true)
    expect(@chart4.xmlUrl?).to eq(false)
  end

  it "should validate the datasource correctly when a json string is passed" do
    @chart5.dataSource = '{"chart": {"caption": "Split of Visitors by Age Group","subCaption": "Last year","paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000","bgColor": "#ffffff","showBorder": "0","use3DLighting": "0","showShadow": "0","enableSmartLabels": "0","startingAngle": "0","showPercentValues": "1","showPercentInTooltip": "0","decimals": "1","captionFontSize": "14","subcaptionFontSize": "14","subcaptionFontBold": "0","toolTipColor": "#ffffff","toolTipBorderThickness": "0","toolTipBgColor": "#000000","toolTipBgAlpha": "80","toolTipBorderRadius": "2","toolTipPadding": "5","showHoverEffect": "1","showLegend": "1","legendBgColor": "#ffffff","legendBorderAlpha": "0","legendShadow": "0","legendItemFontSize": "10","legendItemFontColor": "#666666","useDataPlotColorForLabels": "1"},"data": [{"label": "Teenage","value": "1250400"},{"label": "Adult","value": "1463300"},{"label": "Mid-age","value": "1050700"},{"label": "Senior","value": "491000"}]}'

    expect(@chart5.dataSource.class).to eq(Hash)
  end

end