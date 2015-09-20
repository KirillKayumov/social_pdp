module ApplicationHelper
  def social_icon(provider, account)
    if account.present?
      link_to "", account_path(account),
        class: [provider, "is-connected"],
        data: { method: :delete, confirm: "Do you really want to unlink social account?" }
    else
      link_to "", omniauth_authorize_path(:user, provider), class: provider
    end
  end
end
