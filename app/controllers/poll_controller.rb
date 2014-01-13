class PollController < ApplicationController
  def create
    poll = Poll.create!(params)
    redirect_to poll_show_path(poll)
  end

  def index
    @polls = Poll.list
  end

  def show
    @poll = Poll.fetch_by_id(params[:id])
  end
end
