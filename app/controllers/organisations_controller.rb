class OrganisationsController < ApplicationController
  before_action :find_organisation, only: %i[show edit update destroy]

  def index
    @organisations = Organisation.all
    @organisation = Organisation.new
  end

  def show
    @employments = Employment.where(organisation: @organisation)
    @shifts = Shift.where(organisation: @organisation).order(start: :desc)
    @shift = Shift.new

    # Date filter params
    if params[:start_date].present? || params[:finish_date].present?
      @start_date = params[:start_date].empty? ? "1970-01-01" : params[:start_date]
      @finish_date = params[:finish_date].empty? ? Date.today.strftime("%Y-%m-%d") : params[:finish_date]
      @shifts = @shifts
                  .where(start: @start_date..@finish_date)
                  .where(finish: @start_date..@finish_date)
    end

    # Employee search params
    if params[:query].present?
      @shifts = @shifts.where(user: User.where('full_name ILIKE ?', "%#{params[:query]}%"))
    end

    # Table sort params
    if params[:sort].present? && params[:order].present?
      @shifts = Shift.where(organisation: @organisation).order("#{params[:sort]} #{params[:order]}")
    end
    
    respond_to do |format|
      format.html
      format.text { render partial: 'shifts.html', locals: { shifts: @shifts } }
    end
  end

  def create
    @organisation = Organisation.new(organisation_params)
    respond_to do |format|
      if @organisation.save
        format.html { redirect_to organisations_path, notice: 'Organisation was successfully created' }
        format.json
      else
        @organisations = Organisation.all
        format.html { render :index }
        format.json
      end
    end
  end

  def edit; end

  def update
    if @organisation.update(organisation_params)
      redirect_to organisations_path, notice: 'Organisation was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @employments = Employment.where(organisation: @organisation)
    @employments.each { |employment| employment.destroy }
    @shifts = Shift.where(organisation: @organisation)
    @shifts.each { |shift| shift.destroy }
    if @organisation.delete
      redirect_to organisations_path, notice: 'Organisation was successfully deleted'
    else
      redirect_to edit_organisation(@organisation), notice: 'Unable to delete organisation'
    end
  end

  private

  def find_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name, :hourly_rate)
  end
end
