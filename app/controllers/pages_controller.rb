class PagesController < ApplicationController
include PagesHelper
  def index
    data_controller = DataController.new
    data_controller.index
    @foxbusiness_items = data_controller.instance_variable_get(:@foxbusiness_items)
    @thehill_items = data_controller.instance_variable_get(:@thehill_items)
    @epochtimes_items = data_controller.instance_variable_get(:@epochtimes_items)
    @nyt_items = data_controller.instance_variable_get(:@nyt_items)
    @theintercept_items = data_controller.instance_variable_get(:@theintercept_items)
    @dailymail_items = data_controller.instance_variable_get(:@dailymail_items)
    @infowars_items = data_controller.instance_variable_get(:@infowars_items)
    @thedispatch_items = data_controller.instance_variable_get(:@thedispatch_items)
    @reuters_items = data_controller.instance_variable_get(:@reuters_items)
    @democracynow_items = data_controller.instance_variable_get(:@democracynow_items)
    @sources = ['thehill', 'foxbusiness', 'epochtimes', 'nyt', 'theintercept', 'dailymail', 'infowars', 'thedispatch', 'reuters', 'democracynow'] # Add other sources as needed
  end
end
