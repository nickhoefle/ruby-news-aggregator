class PagesController < ApplicationController
    def index
      data_controller = DataController.new
      data_controller.index
      @items = data_controller.instance_variable_get(:@items)
    end
  end
  