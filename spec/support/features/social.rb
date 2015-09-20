module FeatureHelpers
  def click_social_icon(provider)
    find(".#{provider}").click
  end
end
