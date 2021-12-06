class EmploymentsController < ApplicationController
  def create
    @organisation = Organisation.find(params[:organisation_id])
    @employment = Employment.new(user: current_user, organisation: @organisation)
    if @employment.save
      redirect_to organisations_path, notice: "You have successfully joined an organisation."
    else
      render "organisations/index"
    end
  end

  def destroy
    @employment = Employment.find(params[:id])
    if @employment.destroy
      redirect_to organisations_path, notice: "You have successfully left an organisation."
    else
      render "organisation/index"
    end
  end
end
