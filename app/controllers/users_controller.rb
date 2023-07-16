class UsersController < ApplicationController
    def block_source
      source = params[:source] # Assuming the source is passed as a parameter
      if current_user.block_source(source)
        flash[:notice] = "#{source} has been blocked."
      else
        flash[:error] = "Failed to block #{source}."
      end
      redirect_to root_path
    end
  
    def unblock_source
      source = params[:source] # Assuming the source is passed as a parameter
      if current_user.unblock_source(source)
        flash[:notice] = "#{source} has been unblocked."
      else
        flash[:error] = "Failed to unblock #{source}."
      end
      redirect_to root_path
    end
  
    def update_blocked_sources
      blocked_sources = params[:blocked_sources] || []
      current_user.update(blocked_sources: blocked_sources)
      redirect_to root_path
    end
  end
  