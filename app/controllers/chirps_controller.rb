class ChirpsController < ApplicationController

  def index
    @chirps = Chirp.all.includes(:author, :likes)
    # render json: @chirps
    render :index
  end

  def show
    # debugger
    @chirp = Chirp.find(params[:id])
    # render json: @chirp
    render :show
  end

  def create
    # debugger
    @chirp = Chirp.new(chirp_params)
    if @chirp.save
      # redirect_to chirp_url(@chirp.id)
      # redirect_to "localhost:3000/chirps/#{@chirp.id}"
      redirect_to chirp_url(@chirp)
    else
      render json: @chirp.errors.full_messages, status: 422
    end
  end

  def update
    @chirp = Chirp.find(params[:id])
    if @chirp.update(chirp_params)
      redirect_to chirp_url(@chirp)
    else
      render json: @chirp.errors.full_messages, status: 422
    end
  end

  def destroy
    @chirp = Chirp.find(params[:id])
    @chirp.destroy
    redirect_to chirps_url
  end

  def chirp_params
    params.require(:chirp).permit(:author_id, :body)
  end

end