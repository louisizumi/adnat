class ShiftsController < ApplicationController
  before_action :find_organisation, :get_shifts, except: %i[destroy]
  before_action :find_shift, only: %i[update destroy]

  def index
    @shift = Shift.new
    if params[:start_date].present? || params[:finish_date].present?
      @start_date = params[:start_date].empty? ? "1970-01-01" : params[:start_date]
      @finish_date = params[:finish_date].empty? ? Date.today.strftime("%Y-%m-%d") : params[:finish_date]
      @shifts = @shifts
                  .where(start: @start_date..@finish_date)
                  .where(finish: @start_date..@finish_date)
    end
    if params[:query].present?
      @shifts = @shifts.where(user: User.where('full_name ILIKE ?', "%#{params[:query]}%"))
    end
    if params[:sort].present? && params[:order].present?
      @shifts = Shift.where(organisation: @organisation).order("#{params[:sort]} #{params[:order]}")
    end
    respond_to do |format|
      format.html
      format.text { render partial: 'shifts.html', locals: { shifts: @shifts } }
    end
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.user = current_user
    @shift.organisation = @organisation
    if @shift.save
      redirect_to shifts_path, notice: 'Shift was successfully created'
    else
      render :index
    end
  end

  def update
    if @shift.update(shift_params)
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
  end

  def shift_params
    @shift_params = params.require(:shift).permit(:start_date, :start_time, :finish, :break)
    @shift_params[:start] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:start_time]}")
    if @shift_params[:start_time] > @shift_params[:finish]
      @shift_params[:start_date] = (Date.parse(@shift_params[:start_date]) + 1).to_s
      @shift_params[:finish] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:finish]}")
    else
      @shift_params[:finish] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:finish]}")
    end
    return @shift_params
  end
end
