class SchedulesController < ApplicationController

  before_filter do
    @schedulable = Place.find(params[:place_id]) unless params[:place_id].nil?
    @selected_day = params[:day]
  end

  def index
    @schedules = @schedulable.schedules.for_index
  end

  def new
    @schedule = @schedulable.schedules.build unless @schedulable.nil?
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = @schedulable.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = t(:schedule_created)
      redirect_to selected_place_path(@schedulable)
    else
      render action: 'new'
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = t(:schedule_updated)
      redirect_to selected_place_path(@schedulable)
    else
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to place_schedules_path(@schedulable)
  end

  private
  def schedule_params
    params.require(:schedule).permit(
      :day_of_week,
      :start_time,
      :end_time)
  end
end
