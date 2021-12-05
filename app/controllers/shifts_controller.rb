class ShiftsController < ApplicationController
  before_action :find_organisation, :get_shifts, except: %i[destroy]
  before_action :find_shift, only: %i[update destroy]

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
    @shift.organisation = @organisation
    if @shift.save
      redirect_to shifts_path, notice: 'Shift was successfully created'
    else
      render :index
    end
  end

  def update
    @shift_params = shift_params
    @shift_params[:start] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:start_time]}")
    if @shift_params[:start_time] > @shift_params[:finish]
      @shift_params[:start_date] = (Date.parse(@shift_params[:start_date]) + 1).to_s
      @shift_params[:finish] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:finish]}")
    else
      @shift_params[:finish] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:finish]}")
    end
    if @shift.update(@shift_params)
      redirect_to shifts_path, notice: 'Shift was successfully created'
    else
      render :index
    end
  end

  def destroy
    if @shift.delete
      redirect_to shifts_path, notice: 'Shift was successfully deleted'
    else
      redirect_to shifts_path, notice: 'Unable to delete shift'
    end
  end

  private

  def find_shift
    @shift = Shift.find(params[:id])
  end

  def find_organisation
    @organisation = Organisation.find(current_user.organisation_id)
  end

  def get_shifts
    @shifts = Shift.where(organisation: @organisation).order(start: :desc)
    @current_shifts = @shifts.select { |shift| shift.user.organisation == shift.organisation }
    @previous_shifts = @shifts.reject { |shift| shift.user.organisation == shift.organisation }
  end

  def shift_params
    params.require(:shift).permit(:start_date, :start_time, :finish, :break)
  end
end
