class ShiftsController < ApplicationController
  before_action :find_organisation, :get_shifts

  def index
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.start = DateTime.parse("#{@shift.start_date} #{@shift.start_time}")
    if @shift.start_time > @shift.finish
      @shift.finish = DateTime.parse("#{@shift.start_date + 1} #{@shift.finish}")
    else
      @shift.finish = DateTime.parse("#{@shift.start_date} #{@shift.finish}")
    end
    @shift.user = current_user
    if @shift.save
      redirect_to shifts_path, notice: 'Shift was successfully created'
    else
      render :index
    end
  end

  private

  def find_organisation
    @organisation = Organisation.find(current_user.organisation_id)
  end

  def get_shifts
    @shifts = @organisation.shifts
  end

  def shift_params
    params.require(:shift).permit(:start_date, :start_time, :finish, :break)
  end
end
