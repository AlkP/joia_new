class MainController < ApplicationController
  include ApplicationHelper
  def index

    filter = Hash.new
    filter["country"] = Array.new
    filter["region"] = Array.new
    filter["search_category"] = Array.new
    filter["manufacturer"] = Array.new
    filter["price"] = Array.new
    filter["open_list"] = Hash.new
    filter["hard_liquor"] = false

    session[:filterMain]  = filter

    @stories = Story.all.order('weight ASC').limit(4)
    @first = true
    @n1 = 5
    @n2 = 7
    @max = ((Story.all.count - 4) <= 0) ? true : false
    @catalogs = apply_filter
  end
  def show_more_stories
    n1 = params[:n1].to_i
    n2 = params[:n2].to_i

    story = Story.all
    @stories = story.where('id in (?)', story.order('weight DESC').limit(story.count - n1 + 1).pluck(:id) ).order('weight ASC').limit(n2 - n1 + 1)

    @n1 = n1 + 3
    @n2 = n2 + 3

    @first = false

    @max = ((Story.all.count - n2) <= 0) ? true : false

  end
end
