# Fusioncharts Rails

[![Gem Version](https://badge.fury.io/rb/fusioncharts-rails.svg)](http://badge.fury.io/rb/fusioncharts-rails)
[![Code Climate](https://codeclimate.com/github/fusioncharts/rails-wrapper/badges/gpa.svg)](https://codeclimate.com/github/fusioncharts/rails-wrapper)

Rails wrapper to build charts using FusionCharts. [http://www.fusioncharts.com](http://www.fusioncharts.com)

## Installation (RubyGems)

Add this line to your application's Gemfile:

    gem 'fusioncharts-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fusioncharts-rails

## Installation (Manual)

Step 1: Copy all files from `fusioncharts-suite-xt > integrations > rubyonrails > fusioncharts-wrapper` folder.

Step 2: Paste the copied files to the `/lib` folder of your application.


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

### Adding Event(s).
This is a public method used to generate the html code to add an event to a chart. This function assumes that you've already included the FusionCharts JavaScript class in your page. The following parameters have to be passed in order to attach event function.

~~~
@chart.addEvent("dataLoaded", "onDataLoaded")
~~~

| Parameter | Type | Description |
|:-------|:----------:| :------|
|eventName | `String` | Which event you want to bind. e.g. `dataLoaded`.|
|funcName | `String` | Javascript function, which is written in your client side code|






======================================================================================================
### **FusionTime:**

**Create the chart object with TimeSeries chart with the required parameters as shown below.**

~~~
fusionTable = Fusioncharts::FusionTable.new(schema, data)
timeSeries = Fusioncharts::TimeSeries.new(fusionTable)

#Wrapper constructor parameters
Chart = Fusioncharts::Chart.new({ width: "700", height: "450", type: "timeseries", renderAt: "chartContainer", dataFormat: 'json', timeSeries: timeSeries })

return Chart
~~~

There are two classes that you need to use in order to create a TimeSeries chart, `FusionTable` and `TimeSeries`.

### **Constructor parameters of FusionTable :**
This class creates `timeseries` compatible `FusionTable` object which later passed to the TimeSeries class constructor.

~~~
# Creating FusionTable
fusionTable = Fusioncharts::FusionTable.new(schema, data)
~~~

Let you set the following parameters in FusionTable constructor.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|schema | `String` | The schema which defines the properties of the columns|
|data | `String` | The actual values for each row and column of the DataTable|

### **Data operation:**

FusionTable also supports following DataTable operations:

* Select
* Sort
* Filter
* Pipe

**`Select`** operation should be used only when you want to see few specific columns of the DataTable.

~~~
fusionTable = Fusioncharts::FusionTable.new(schema, data)

# Column names as parameter
fusionTable.Select("Country", "Sales")
~~~

| Parameter | Type | Description |
|:-------|:----------:| :------|
|columnName | `String` | Define multiple columns name.|

**`Sort`** one of the major requirements while working with large sets of data is to sort the data in a specific order - most commonly, ascending or descending.

~~~
fusionTable = Fusioncharts::FusionTable.new(schema, data)

#column name and orderby
fusionTable.Sort("Sales", FusionTable::OrderBy::ASC)
~~~

| Parameter | Type | Description |
|:-------|:----------:| :------|
|columnName | `String` | Define column name on which sorting will be applied.|
|columnOrderBy | `Integer` | To sort the column in descending or ascending order. e.g. `FusionTable.OrderBy.ASC, FusionTable.OrderBy.DESC`|

**`Filter`** comes with a set of operations that you can use to filter data values from a large dataset, based on one or more conditions. Supported filter operations are:

* Equals
* Greater
* GreaterEquals
* Less
* LessEquals
* Between

~~~
# Filter - Equal
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::Equals, "Country", "United States")

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

~~~
# Filter - Greater
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::Greater, "Quantity", 100)

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

~~~
# Filter - GreaterEquals
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::GreaterEquals, "Quantity", 100)

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

~~~
# Filter - Less
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::Less, "Quantity", 100)

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

~~~
# Filter - LessEquals
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::LessEquals, "Quantity", 100)

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

~~~
# Filter - Between
# Creating filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::Between, "Quantity", 100, 1000)

#Applying the filter on fusion table
fusionTable.ApplyFilter(filter1)
~~~

let you set the following parameter of `CreateFilter` method for creating filter statement.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filterType | `Integer` | Define the filter type. e.g. `FusionTable.FilterType.Equals`, `FusionTable.FilterType.Greater` etc.|
|columnName | `String` | Define column name on which the filter will be applied.|
|values | `Object` | Define filter value(s). e.g. `String`, `Integer` values.|

let you set the following parameter of `ApplyFilter` method for applying the filter on fusion table.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filter | `String` | Define the `Filter statement`|

~~~
# Filter - Apply conditional filter
# Define anonymous function to filter
fusionTable.ApplyFilterByCondition("(row, columns) => {
                   	return row[columns.Country] === 'USA' ||
                   	(row[columns.Sales] > 100 && row[columns.Shipping_Cost] < 10);
                    }")
~~~

**`Pipe`**  is an operation which lets you run two or more data operations in a sequence. Instead of applying multiple filters one by one to a DataTable which creates multiple DataTable(s), you can combine them in one single step using pipe and apply to the DataTable. This creates only one DataTable.

~~~
fusionTable = Fusioncharts::FusionTable.new(schema, data)

# Creating first filter statement by passing the filter type, column name and filter value
filter1 = fusionTable.CreateFilter(Fusioncharts::FilterType::Equals, "Country", "India")

# Creating second filter statement by passing the filter type, column name and filter value
filter2 = fusionTable.CreateFilter(Fusioncharts::FilterType::Greater, "Quantity", 100)

#Applying multiple filters one by one to a DataTable
fusionTable.Pipe(filter1, filter2)
~~~

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filters | `String` | Define multiple filters.|

### **Constructor parameter of TimeSeries :**
This class creates `timeseries` compatible `TimeSeries` object which later passed to the chart object.

~~~
# Creating TimeSeries object
timeSeries = Fusioncharts::TimeSeries.new(fusionTable)
~~~

let you set the following parameter in TimeSeries constructor.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|fusionTable | `FusionTable` | The Datatable which defines the schema and actual data (FusionTable).|

#### Methods ####

**`AddAttribute`** is a public method to accept data as a form of JSON string to configure the chart attributes. e.g. `caption`, `subCaption`, `xAxis` etc.

~~~
fusionTable = Fusioncharts::FusionTable.new(schema, data)
timeSeries = Fusioncharts::TimeSeries.new(fusionTable)
 
timeSeries.AddAttribute("caption", "{
                                    	text: ' Online Sales'
                                  	}")
~~~

let you set the following parameter in `AddAttribute` method.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|key | `String` | The attribute name.|
|value | `String` | Define json formatted value.|

### License

**FUSIONCHARTS:**

Copyright (c) FusionCharts Technologies LLP  
License Information at [http://www.fusioncharts.com/license](http://www.fusioncharts.com/license)