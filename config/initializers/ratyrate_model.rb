require 'active_support/concern'
module Ratyrate
  extend ActiveSupport::Concern

  def can_rate_for_pickup?(pick_up_id, user, dimension=nil)
    user.ratings_given.where(pick_up_id: pick_up_id, dimension: dimension, rateable_id: id, rateable_type: self.class.name).size.zero?
  end

  def rate_for_pickup(pick_up_id, stars, user, dimension=nil, dirichlet_method=false)
    dimension = nil if dimension.blank?

    if can_rate_for_pickup? pick_up_id, user, dimension
      rates(dimension).create! do |r|
        r.stars = stars
        r.rater = user
        r.pick_up_id = pick_up_id
      end
      if dirichlet_method
        update_rate_average_dirichlet(stars, dimension)
      else
        update_rate_average(stars, dimension)
      end
    else
      update_current_rate(stars, user, dimension)
    end
  end

end
