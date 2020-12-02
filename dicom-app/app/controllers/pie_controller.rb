class PieController < ApplicationController

  def index
    @graph = open_flash_chart_object(800,600,"/pie/graph_code")
  end

  def graph_code
    # Determine the distribution of examination studies in the database:
    examinations = Examination.all
    studies = Array.new
    examinations.each do |e|
      studies << e.study
    end
    unique = studies.uniq
    results = Hash.new
    unique.each do |u|
      results[u] = studies.select{|s| s == u}.length
    end
    # Create the pie chart and insert the determined data:
    title = Title.new("Distribution of Studies")
    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent#'
    pie.colours = ["#0000ff", "#ff0000", "#00ff00"]
    values = Array.new
    results.each do |k, v|
      values << PieValue.new(v, k)
    end
    pie.values = values
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.x_axis = nil
    render :text => chart.to_s
  end

end
