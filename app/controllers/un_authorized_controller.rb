class UnAuthorizedController < ApplicationController
  def index
    render status: :forbidden
  end
end
