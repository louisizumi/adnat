class UsersController < ApplicationController
  before_action :find_user

  def join
    @organisation = Organisation.find(params[:organisation_id])
    if @user.update(organisation: @organisation)
      redirect_to home_path, notice: "You have successfully joined an organisation."
    else
      render "organisations/index"
    end
  end

  def leave
    if @user.update(organisation: nil)
      redirect_to organisations_path, notice: "You have successfully left an organisation."
    else
      render "pages/home"
    end
  end

  private

  def find_user
    @user = User.find(current_user.id)
  end
end
