class PagesController < ApplicationController
  def index
    data_controller = DataController.new
    data_controller.request = request # Set the request object for DataController
    data_controller.response = response # Set the response object for DataController
    data_controller.index # Call the index action of DataController
    @foxbusiness_items = data_controller.instance_variable_get(:@foxbusiness_items)
    @thehill_items = data_controller.instance_variable_get(:@thehill_items)
  end
end
