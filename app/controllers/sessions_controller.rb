class SessionsController < Devise::SessionsController
  expose(:provider) { params[:provider] }
  expose(:uid) { params[:uid] }

  def create
    super do |resource|
      if provider.present? && uid.present?
        resource.accounts.create(provider: provider, uid: uid)
      end
    end
  end
end
