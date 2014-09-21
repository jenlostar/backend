class SchedulesController < ApplicationController

  add_breadcrumb 'Lugares', :places_path
  add_breadcrumb 'Horarios'

  before_filter do
    @schedulable = Place.find(params[:place_id]) unless params[:place_id].nil?
  end

  def index
    @schedules = @schedulable.schedules.for_index
  end

  def new
    add_breadcrumb 'Nuevo'
    @schedule = @schedulable.schedules.build unless @schedulable.nil?
  end

  def edit
    add_breadcrumb 'Editar'
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = t('.the_new_place_has_been_updated')
      redirect_to place_schedules_path(@schedulable)
    else
      add_breadcrumb 'Editar'
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to place_schedules_path(@schedulable)
  end

  def create
    @schedule = @schedulable.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = t('.the_new_place_has_been_created')
      redirect_to place_schedules_path(@schedulable)
    else
      add_breadcrumb 'Nuevo'
      render action: 'new'
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(
      :day_of_week,
      :start_time,
      :end_time)
  end
end
