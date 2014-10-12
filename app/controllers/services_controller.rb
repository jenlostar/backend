class ServicesController < ApplicationController

  before_action do
    @place = Place.find(params[:place_id]) unless params[:place_id].nil?
  end

  def new
    @service = @place.services.build
  end

  def edit
    @service = Service.find(params[:id])
  end

  def create
    @service = @place.services.build(service_params)
    if @service.save
      flash[:success] = t(:service_created)
      redirect_to selected_place_path(@place)
    else
      render action: 'new'
    end
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      flash[:success] = t(:service_updated)
      redirect_to selected_place_path(@place)
    else
      render 'edit'
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to selected_place_path(@place)
  end

  private
  def service_params
    params.require(:service).permit(:name,
                                    :kind,
                                    :minimum_amount,
                                    :maximum_amount,
                                    :duration)
  end

end
