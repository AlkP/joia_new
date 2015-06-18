module ApplicationHelper
  # n1 - начало выборки
  # n2 - конец выборки
  # type - По какой цене смотреть
  def apply_filter(n1 = 1, n2 = 12, type = 1)

    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]

    list_manufacturer = Array.new

    catalog = (filter.nil? or filter["hard_liquor"] == false) ? Catalog.where('catalogs.hard_liquor is NULL or catalogs.hard_liquor = ?', false) : Catalog.where('catalogs.hard_liquor = ?', true)

    unless filter.nil? or (filter["country"] == [] and filter["region"] == [] and filter["manufacturer"] == [] and filter["search_category"] == [] and filter["price"] == [])
      unless (filter["country"] == [] and filter["region"] == [] and filter["manufacturer"] == [])
        filter["manufacturer"].each do |m|
          list_manufacturer += [m]
        end

        if filter["region"].length == 0 && filter["manufacturer"].length == 0
          Manufacturer.where('country_id in (?)', filter["country"]).each do |m|
            list_manufacturer << m.id
          end
        end

        if filter["manufacturer"].length == 0
          Manufacturer.where('region_id in (?)', filter["region"]).each do |m|
            list_manufacturer << m.id
          end
        end

        catalog = catalog.where('manufacturer_id in (?)', list_manufacturer)
      end

      unless (filter["search_category"] == [])
        catalog = catalog.where('search_category_id in (?)', filter["search_category"])
      end

      # Обрабатываем цены
      unless (filter["price"] == [])
        catalog_id = Array.new
        filter["price"].each do |price|
          case price
            when "1"
              catalog_id = Price.where('type_id = ? and price >= ? and price < ?', type, 0, 550).pluck(:catalog_id)
            when "2"
              catalog_id = Price.where('type_id = ? and price >= ? and price < ?', type, 550, 1000).pluck(:catalog_id)
            when "3"
              catalog_id = Price.where('type_id = ? and price >= ? and price < ?', type, 1000, 2000).pluck(:catalog_id)
            when "4"
              catalog_id = Price.where('type_id = ? and price >= ? and price < ?', type, 2000, 3000).pluck(:catalog_id)
            when "5"
              catalog_id = Price.where('type_id = ? and price >= ?', type, 3000 ).pluck(:catalog_id)
          end
        end
        catalog = catalog.where( 'catalogs.id in (?)', catalog_id )
      end
    end

    session[:sort] = 'search_category' if session[:sort].nil?
    # Получаем выбранный диапазон записей
    case session[:sort]
      when 'search_category'
        @max = ((catalog.count - n2) <= 0) ? true : false

        # catalog = catalog.where('id in (?)', catalog.order('search_category_id DESC').order('id DESC').limit(catalog.count - n1 + 1).pluck(:id) ).order('search_category_id ASC').order('id ASC').limit(n2 - n1 + 1)

        catalogDESC = catalog.joins("LEFT JOIN search_categories ON search_categories.id = catalogs.search_category_id").order('search_categories.weight DESC').order('catalogs.weight DESC')
        catalog = catalog.where('catalogs.id in (?)', catalogDESC.limit(catalog.count - n1 + 1).pluck(:id))
        catalogASC = catalog.joins("LEFT JOIN search_categories ON search_categories.id = catalogs.search_category_id").order('search_categories.weight ASC').order('catalogs.weight ASC')
        catalog = catalogASC.limit(n2 - n1 + 1)

      when 'price'
        price = Price.where('catalog_id in (?) and type_id = ?', catalog.pluck(:id), type)
        @max = ((price.count - n2) <=0) ? true : false

        catalogDESC = catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).order('prices.price DESC').order('catalogs.weight DESC').limit(price.count - n1 + 1)
        catalogASC = catalogDESC.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).order('prices.price ASC').order('catalogs.weight ASC').limit(n2 - n1 + 1)

        catalog = catalogASC

      when 'region'
        @max = ((catalog.count - n2) <= 0) ? true : false
        catalogDESC = catalog.joins("LEFT JOIN search_categories ON search_categories.id = catalogs.search_category_id").order('search_categories.weight DESC').order('catalogs.weight DESC')
        catalog = catalog.where('catalogs.id in (?)', catalogDESC.limit(catalog.count - n1 + 1).pluck(:id))
        catalogASC = catalog.joins("LEFT JOIN search_categories ON search_categories.id = catalogs.search_category_id").order('search_categories.weight ASC').order('catalogs.weight ASC')
        catalog = catalogASC.limit(n2 - n1 + 1)
    end

    @n1 = n2 + 1
    @n2 = n2 + 12

    return catalog

  end


  # <% n1 = 5 %>
  # <% n2 = 10 %>
  # <%= Catalog.where('id in (?)', Catalog.all.order('id DESC').limit(Catalog.all.count - n1 + 1).pluck(:id) ).order('id ASC').limit(n2 + 1).pluck(:id) %>



  def check_teenager(controller)
    teenager = session[:teenager]
    unless teenager.nil?
      if teenager[controller]
        return false
      else
        return true
      end
    else
      return true
    end
  end

  def getFilter
    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]
    @filterCountry = Hash.new
    @filterCountry["0"] = true
    @filterRegion = Hash.new
    @filterRegion["0"] = true
    @filterSearchCategory = Hash.new
    @filterSearchCategory["0"] = true
    @filterManufacturer = Hash.new
    @filterManufacturer["0"] = true
    @filterPrice = Hash.new
    @filterPrice["0"] = true
    unless filter.nil?
      filter["country"].each do |c| @filterCountry[c] = true end
      filter["region"].each do |r| @filterRegion[r] = true end
      filter["search_category"].each do |c| @filterSearchCategory[c] = true end
      filter["manufacturer"].each do |m| @filterManufacturer[m] = true end
      filter["price"].each do |p| @filterPrice[p] = true end
    end
  end

  def checkFilter(type = 1)
    filter = (params[:filterMain] == "true") ? session[:filterMain] : session[:filter]

    @filterPriceAccess = Hash.new

    @searchCategory = SearchCategory.all.order('weight ASC')

    @searchCategory = !(filter.nil? or filter["hard_liquor"] != true)? @searchCategory.where('hard_liquor = ?', true) : @searchCategory.where('hard_liquor is NULL or hard_liquor = ?', false)

    # @searchCategory = @searchCategory.where('id in (?)', filter["search_categories"]) unless filter.nil? or filter["search_category"].count == 0

    catalog = Catalog.all.where('search_category_id in (?)', @searchCategory.pluck(:id))


    unless filter.nil? or filter["price"].count == 0
      filter["price"].each do |p|
        min = 0
        max = 999999
        case p
          when "1"
            min = 0
            max = 550
          when "2"
            min = 550
            max = 1000
          when "3"
            min = 1000
            max = 2000
          when "4"
            min = 2000
            max = 3000
          when "5"
            min = 3000
            max = 999999
        end
        catalog = catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', min, max)
      end
    end

    @manufacturer = Manufacturer.all.order('weight ASC').where('id in (?)', catalog.pluck(:manufacturer_id))
    @country = Country.all.order('weight ASC').where('id in (?)', @manufacturer.pluck(:country_id))
    @region = Region.all.order('weight ASC').where('id in (?)', @manufacturer.pluck(:region_id))

    unless filter.nil?

      unless filter["country"].count == 0
        filter["country"].each do |c|
          @country = @country.where('id = ?', c)
          @region = @region.where('country_id = ?', c)
          @manufacturer = @manufacturer.where('country_id = ?', c)
          catalog = catalog.where('manufacturer_id in (?)', @manufacturer.pluck(:id))
        end
      else
        unless filter["region"].count == 0
          region = Region.find(filter["region"].first)
          @country = @country.where('id = ?', region.country_id)
          @region = @region.where('country_id = ?', @country.first.id)
          @manufacturer = @manufacturer.where('region_id in (?)', filter["region"])
          catalog = catalog.where('manufacturer_id in (?)', @manufacturer.pluck(:id))
        else
          unless filter["manufacturer"].count == 0
            @manufacturer = @manufacturer.where('id in (?)', filter["manufacturer"])
            @country = @country.where('id in (?)', @manufacturer.pluck(:country_id))
            @region = @region.where('id in (?)', @manufacturer.pluck(:region_id))
            catalog = catalog.where('manufacturer_id in (?)', @manufacturer.pluck(:id))
          end
        end
      end

      # @searchCategory = SearchCategory.all.order('weight ASC')

    end

    unless !filter.nil? and !filter["open_list"].nil? and filter["open_list"]["country"]
      @country = @country.limit(3)
    end
    unless !filter.nil? and !filter["open_list"].nil? and filter["open_list"]["region"]
      @region = @region.limit(3)
    end
    unless !filter.nil? and !filter["open_list"].nil? and filter["open_list"]["manufacturer"]
      @manufacturer = @manufacturer.limit(3)
    end

    @filterPriceAccess[1] = (catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', 0, 550).count > 0)        ? true : false
    @filterPriceAccess[2] = (catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', 550, 1000).count > 0)     ? true : false
    @filterPriceAccess[3] = (catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', 1000, 2000).count > 0)    ? true : false
    @filterPriceAccess[4] = (catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', 2000, 3000).count > 0)    ? true : false
    @filterPriceAccess[5] = (catalog.joins("INNER JOIN prices ON prices.catalog_id = catalogs.id").where('prices.type_id = ?', type).where('prices.price >= ? and prices.price < ?', 3000, 999999).count > 0)  ? true : false

  end

end
