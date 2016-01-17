module ApplicationHelper
  def instagram_paginator(markers)
    if markers.count % 13 == 0
      markers.count / 13 + 1
    elsif markers.count == 1
      "1"
    end
  end
end
