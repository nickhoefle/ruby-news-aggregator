class PagesController < ApplicationController
include PagesHelper
  def index
    data_controller = DataController.new
    data_controller.index
    @foxbusiness_items = data_controller.instance_variable_get(:@foxbusiness_items)
    @thehill_items = data_controller.instance_variable_get(:@thehill_items)
    @sources = ['thehill', 'foxbusiness'] # Add other sources as needed
  end
end
