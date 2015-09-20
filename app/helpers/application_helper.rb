module ApplicationHelper
  def social_icon(provider, connected = false)
    url = connected ? "" : omniauth_authorize_path(:user, provider)
    icon_class = connected ? [provider, "is-connected"] : provider

    link_to "", url, class: icon_class
  end
end
