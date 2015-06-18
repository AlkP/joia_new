class FiltersController < ApplicationController
  include ApplicationHelper
  def sleepWait
    sleep(3.0)
  end
  def new

    sleepWait

    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]

    id = params[:id]
    type = params[:type]

    if filter.nil?
      filter = Hash.new
      filter["country"] = Array.new
      filter["region"] = Array.new
      filter["search_category"] = Array.new
      filter["manufacturer"] = Array.new
      filter["price"] = Array.new
      filter["open_list"] = Hash.new
    end

    filter["hard_liquor"] = false if filter["hard_liquor"].nil?

    unless type == 'hard_liquor'
      check = false
      filter[type].each do |f|
        check  = true if f == id
      end
      filter[type] += [id] unless check
    else
      filter[type] = (id == 'false') ? false : true
    end

    session[:filter]      = filter unless params[:filterMain] == "true"
    session[:filterMain]  = filter if params[:filterMain] == "true"

    @filter = filter
    @catalogs = apply_filter

    @flag = (type == 'country')? true : false

    checkFilter

  end

  def destroy

    sleepWait

    session[:filter] = nil if params[:id] == 'all'
    session[:filterMain] = nil if params[:id] == 'all'
    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]
    id = params[:id]
    type = params[:type]

    unless params[:id] == 'all'
      check = Array.new
      filter[type].each do |f|
        check  += [f] unless f == id
      end
      filter[type] = check
      session[:filter]      = filter unless params[:filterMain] == "true"
      session[:filterMain]  = filter if params[:filterMain] == "true"
    else
      # session[:filter]["open_list"] = Hash.new
    end

    @filter = filter
    @catalogs = apply_filter

    checkFilter

  end

  def show_full_filters

    sleepWait

    @url = params[:url]

    # session[:filter]["open_list"] = Hash.new

    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]

    if filter.nil?
      filter = Hash.new
      filter["country"] = Array.new
      filter["region"] = Array.new
      filter["search_category"] = Array.new
      filter["manufacturer"] = Array.new
      filter["price"] = Array.new
      filter["open_list"] = Hash.new
    end
    filter["open_list"] = Hash.new if filter["open_list"].nil?
    case @url
      when 'search__filter1'
        filter["open_list"]["country"] = true
      when 'search__filter2'
        filter["open_list"]["region"] = true
      # when 'search__filter3'
        # filter["open_list"]["йййй"] = true
      when 'search__filter4'
        filter["open_list"]["manufacturer"] = true
      when 'search__filter5'
        filter["open_list"]["price"] = true
    end
    session[:filter]      = filter unless params[:filterMain] == "true"
    session[:filterMain]  = filter if params[:filterMain] == "true"
    checkFilter
  end

  def add_order
    filter = session[:order]
    filter = Hash.new if filter.nil?

    check = false
    filter.each_key do |key|
      check = true if key == params[:id]
    end
    if check
      filter.delete(params[:id])
    else
      filter[params[:id]] = true
    end

    session[:order] = filter

  end

  def change_sort

    sleepWait

    session[:sort] = params[:type]
    @filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]
    @catalogs = apply_filter
  end

  def show_wine
    @catalogs = apply_filter(params[:n1].to_i, params[:n2].to_i)
  end

  def add_teenager
    teenager = session[:teenager]
    teenager = Hash.new if teenager.nil?
    teenager[params[:id]] = true
    session[:teenager] = teenager
  end

end
