require 'prawn'
require 'date'
require_relative '../lib/prawn/charts'

Prawn::Document.generate('chart.pdf') do
  red   = []
  green = []
  blue  = []

  5.times do |i|
    red.push(   { key: i, value: rand(500) + 10 })
    green.push( { key: i, value: rand(400) + 10 })
    blue.push(  { key: i, value: rand(300) + 10 })
  end

  opts = {
    at:      [bounds.width - 500, bounds.top],
    width:   500,
    height:  bounds.height / 4,
    x: {title: 'X Axis', display: true},
    y: {title: 'Y Axis', display: true},
    key_formatter:    lambda{|key| (Date.today >> key).strftime('%b %Y')},
    value_formatter:  lambda{|value| value.to_s},
    series: [
      {
        name:             'Red',
        color:            'FF6961',
        values:           red
      },
      {
        name:             'Green',
        color:            '03C03C',
        values:           green
      },
      {
        name:             'Blue',
        color:            '779ECB',
        values:           blue
      }
    ]
 }

  bar_chart(opts) do |config|
    config.title = 'Bar'
  end

  stacked_bar_chart(opts) do |config|
    config.at = [ config.at.first, config.at.last - config.height]
    config.title = 'Stacked Bar'
  end

  line_chart(opts) do |config|
    config.at = [ config.at.first, config.at.last - config.height * 2]
    config.title = 'Line Chart'
  end


  line_opts = opts.merge({
    x:  {title: 'X Axis' , display: false } ,
    y:  {title: 'Y Axis' , display: false } ,
    y1: {title: 'Y1 Axis', display: true  } ,
    series: [
      {
        name:             'Red',
        color:            'FF6961',
        values:           red
      },
    ]
  })

  bar_opts = opts.merge({
    title: 'Combo Chart',
    x: {title: 'X Axis', display: true},
    y: {title: 'Y Axis', display: true},
    series: [
      {
        name:             'Blue',
        color:            '779ECB',
        values:           blue
      },
    ]
  })
  combo_chart(line_chart: line_opts, bar_chart: bar_opts) do |config|
    line_chart, bar_chart  = config.line_chart, config.bar_chart

    line_chart.config.at = [ line_chart.config.at.first, line_chart.config.at.last - line_chart.config.height * 3]
    bar_chart.config.at  = [ bar_chart.config.at.first, bar_chart.config.at.last - bar_chart.config.height * 3]
  end
end
