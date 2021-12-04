class OrganisationsController < ApplicationController
  before_action :find_console, only: %i[edit update destroy]

  def index
    @organisations = Organisation.all
    @organisation = Organisation.new
  end

  def show; end

  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      redirect_to @organisations, notice: 'Organisation was successfully created'
    else
      render :index
    end
  end

  def edit; end

  def update
    if @organisation.update(organisation_params)
      redirect_to @organisations, notice: 'Organisation was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @organisation.destroy
      redirect_to @organisations, notice: 'Organisation was successfully deleted'
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
