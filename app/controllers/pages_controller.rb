class PagesController < ApplicationController
  def home
    redirect_to organisations_path unless current_user.organisation
    @organisation = current_user.organisation
  end
end
