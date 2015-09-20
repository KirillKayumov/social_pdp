class AccountsController < ApplicationController
  respond_to :html

  expose(:account) { current_user.accounts.find(params[:id]) }

  def destroy
    account.destroy

    respond_with account, location: edit_user_registration_path
  end
end
