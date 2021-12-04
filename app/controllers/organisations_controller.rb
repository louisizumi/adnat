class OrganisationsController < ApplicationController
  before_action :find_organisation, only: %i[show edit update destroy]

  def index
    redirect_to home_path if current_user.organisation
    @organisations = Organisation.all
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      redirect_to organisations_path, notice: 'Organisation was successfully created'
    else
      render :index
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
    User.where(organisation: @organisation).update_all(organisation_id: nil)
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
