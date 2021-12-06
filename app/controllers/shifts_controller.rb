class ShiftsController < ApplicationController
  before_action :find_organisation, except: %i[update destroy]
  before_action :get_shifts, :get_employments, except: %i[destroy]
  before_action :find_shift, only: %i[update destroy]

  def create
    @shift = Shift.new(shift_params)
    @shift.user = current_user
    @shift.organisation = @organisation
    respond_to do |format|
      if @shift.save
        format.html { redirect_to @organisation, notice: 'Shift was successfully created' }
        format.json
      else
        @shift = Organisation.all
        format.html { render organisations_path }
        format.json
      end
    end
  end

  def update
    @organisation = @shift.organisation
    if @shift.update(shift_params)
      redirect_to @organisation, notice: 'Shift was successfully updated'
    else
      render :index
    end
  end

  def destroy
    @organisation = @shift.organisation
    if @shift.delete
      redirect_to @organisation, notice: 'Shift was successfully deleted'
    else
      redirect_to @organisation, notice: 'Unable to delete shift'
    end
  end

  private

  def find_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end
  
  def get_shifts
    @shifts = Shift.where(organisation: @organisation).order(start: :desc)
  end
  
  def get_employments
    @employments = Employment.where(organisation: @organisation)
  end

  def find_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    @shift_params = params.require(:shift).permit(:start_date, :start_time, :finish, :break)
    
    # Calculate start time from virtual attributes
    @shift_params[:start] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:start_time]}")
    
    # Calculate overnight shift from virtual attributes
    if @shift_params[:start_time] >= @shift_params[:finish]
      @shift_params[:finish] = DateTime.parse("#{(Date.parse(@shift_params[:start_date]) + 1).to_s} #{@shift_params[:finish]}")
    else
      @shift_params[:finish] = DateTime.parse("#{@shift_params[:start_date]} #{@shift_params[:finish]}")
    end
    
    @shift_params
  end
end
