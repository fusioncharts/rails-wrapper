# Fusioncharts Rails

[![Gem Version](https://badge.fury.io/rb/fusioncharts-rails.svg)](http://badge.fury.io/rb/fusioncharts-rails)
[![Code Climate](https://codeclimate.com/github/fusioncharts/rails-wrapper/badges/gpa.svg)](https://codeclimate.com/github/fusioncharts/rails-wrapper)

Rails wrapper to build charts using FusionCharts. [http://www.fusioncharts.com](http://www.fusioncharts.com)

## Installation

Add this line to your application's Gemfile:

    gem 'fusioncharts-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fusioncharts-rails

## Getting Started
You will have to download the latest fusioncharts library at [http://www.fusioncharts.com/download/](http://www.fusioncharts.com/download/). Once you have downloaded and extracted, copy the `javascript` files into `vendor/assets/javascripts/fusioncharts/`.

Require the following lines in the `app/assets/javascripts/application.js`
~~~
//= require fusioncharts/fusioncharts
//= require fusioncharts/fusioncharts.charts
//= require fusioncharts/themes/fusioncharts.theme.fint
~~~

## Usage Guide

### 1. Creating a chart:
Create the FusionCharts object in the controller action like the following:

~~~

#Filename: app/controllers/dashboard_controller.rb

class DashboardController < ApplicationController

  def index

    @chart = Fusioncharts::Chart.new({
        width: "600",
        height: "400",
        type: "mscolumn2d",
        renderAt: "chartContainer",
        dataSource: {
            chart: {
            caption: "Comparison of Quarterly Revenue",
            subCaption: "Harry's SuperMart",
            xAxisname: "Quarter",
            yAxisName: "Amount ($)",
            numberPrefix: "$",
            theme: "fint",
            exportEnabled: "1",
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
    })

  end

end

~~~

### 2. Render the chart
In order to render the chart, you can use the `render` method in the specific view

~~~

<!-- Filename: app/views/dashboard/index.html.erb -->

<h3>My Chart</h3>
<div id="chartContainer"><%= @chart.render() %></div>

~~~

### 3. Note
- The `dataSource` key (which can be set using the `dataSource` method or passed in as a hash in the chart constructor) can accept data which is in one of the following formats:
  - Valid Ruby Hash
  - JSON String
  - XML String
- Also look at [FusionCharts Export Handler](https://github.com/fusioncharts/rails-exporter) to understand how to export a chart to different image formats and PDF.

## API Methods

### Set width of the chart.
~~~
@chart.width = 600
~~~

### Set height of the chart.
~~~
@chart.height = 400
~~~

### Set the chart type. 
~~~
@chart.type = "column2d"
~~~

### Set the datasource format of the chart.
~~~
@chart.dataFormat = "json"
~~~

### Set the datasource format of the chart.
~~~
@chart.dataSource = {
    chart: {
            caption: "Comparison of Quarterly Revenue",
            subCaption: "Harry's SuperMart",
            xAxisname: "Quarter",
            yAxisName: "Amount ($)",
            numberPrefix: "$",
            theme: "fint",
            exportEnabled: "1",
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
~~~

### Set the url from where the datasource should be fetched. This must be a valid `json` data.
~~~
@chart.jsonUrl = "/data/chart.json"
~~~

### Set the url from where the datasource should be fetched. This must be a valid `xml` data.
~~~
@chart.xmlUrl = "/data/chart.xml"
~~~

### Set the DOM id where the chart should be rendered.
~~~
@chart.renderAt = "chartContainer"
~~~

### Render the chart.
~~~
@chart.render()
~~~
