class SchedulesController < ApplicationController
  before_action do
    @place = Place.find(params[:place_id]) unless params[:place_id].nil?
    @selected_day = params[:day]
  end

  def new
    generate_schedule
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    if @place.batch_create_schedules(batch_params).any?
      flash[:success] = t(:schedule_created)
      redirect_to selected_place_path(@place)
    else
      flash[:danger] = t(:schedule_no_created)
      generate_schedule
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

  def generate_schedule
    @schedule = @place.schedules.build unless @place.nil?
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time, day_of_week: [])
  end

  def batch_params
    schedule_params[:day_of_week].try(:map) do |day|
      next nil if day.blank?
      schedule_params.tap { |s| s.delete(:day_of_week) }.merge(day_of_week: day)
    end.try(:compact)
  end
end
