class SchedulesController < ApplicationController

  before_action do
    @place = Place.find(params[:place_id]) unless params[:place_id].nil?
    @selected_day = params[:day]
  end

  def index
    @schedules = @place.schedules.for_index
  end

  def new
    @schedule = @place.schedules.build unless @place.nil?
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = @place.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = t(:schedule_created)
      redirect_to selected_place_path(@place)
    else
      render action: 'new'
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = t(:schedule_updated)
      redirect_to selected_place_path(@place)
    else
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to selected_place_path(@place)
  end

  private
  def schedule_params
    params.require(:schedule).permit(:day_of_week, :start_time, :end_time)
  end
end
