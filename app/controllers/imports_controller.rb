class ImportsController < ApplicationController
  def create
    CSV.foreach(params[:file].path, :headers => true) do |l|
      name = l["Name"].strip unless l["Name"].nil?
      unless name.nil?
        # Обрабатываем сахар
        sugar = l["Sugar"].strip unless l["Sugar"].nil?
        unless sugar.nil?
          Sugar.create(name: sugar) if Sugar.where('name = ?', sugar).first.nil?
        end
        (Sugar.where('name = ?', sugar).first.nil?) ?
          sugar_id = nil :
          sugar_id = Sugar.where('name = ?', sugar).first.id

        # Обрабатываем категорию
        category = l["Category"].strip unless l["Category"].nil?
        unless category.nil?
          Category.create(name: category) if Category.where('name = ?', category).first.nil?
        end
        (Category.where('name = ?', category).first.nil?) ?
          category_id = nil :
          category_id = Category.where('name = ?', category).first.id

        # Обрабатываем страну
        country = l["Country"].strip unless l["Country"].nil?
        unless country.nil?
          Country.create(name: country) if Country.where('name = ?', country).first.nil?
          country_id = Country.where('name = ?', country).first
          (country_id.nil?)? country_id = nil : country_id = country_id.id

          # Обрабатываем регион
          region = l["Region"].strip unless l["Region"].nil?
          unless region.nil?
            Region.create(name: region, country_id: country_id) if Region.where('name = ?', region).first.nil?
          end
          region_id = Region.where('name = ?', region).first
          (region_id.nil?)? region_id = nil : region_id = region_id.id
        end

        # Обрабатываем производителя
        manufacturer = l["Manufacturer"].strip unless l["Manufacturer"].nil?
        unless manufacturer.nil?
          Manufacturer.create(name: manufacturer, country_id: country_id, region_id: region_id) if Manufacturer.where('name = ?', manufacturer).first.nil?
        end
        manufacturer_id = Manufacturer.where('name = ?', manufacturer).first
        (manufacturer_id.nil?)? manufacturer_id = nil : manufacturer_id = manufacturer_id.id

        # Обрабатываем цвет
        color = l["Color"].strip unless l["Color"].nil?
        unless color.nil?
          Color.create(name: color) if Color.where('name = ?', color).first.nil?
        end
        color_id = Color.where('name = ?', color).first
        (color_id.nil?)? color_id = nil : color_id = color_id.id

        # Обрабатываем категорию поиска
        search_category = l["SearchCategory"].strip unless l["SearchCategory"].nil?
        unless search_category.nil?
          SearchCategory.create(name: search_category) if SearchCategory.where('name = ?', search_category).first.nil?
        end
        search_category_id = SearchCategory.where('name = ?', search_category).first
        (search_category_id.nil?)? search_category_id = nil : search_category_id = search_category_id.id

        # Создаем запись
        (l["abv"].nil?)? abv = nil : abv = l["abv"].gsub("%", "")
        (l["Barcode"].nil?)? barcode = nil : barcode = l["Barcode"].gsub(" ", "")

        (l["NameEng"].nil?)? name_eng = nil : name_eng = l["NameEng"].strip
        (l["Description"].nil?)? description = nil : description = l["Description"].strip
        (l["Honors"].nil?)? honors = nil : honors = l["Honors"].strip

        catalog = Catalog.create(name:name,
                                 name_eng: name_eng,
                                 description: description,
                                 description_eng: description,
                                 abv: abv,
                                 volume: l["Volume"],
                                 amount: l["Amount"],
                                 honors: honors,
                                 barcode: barcode,
                                 year: l["Year"],
                                 sugar_id: sugar_id,
                                 manufacturer_id: manufacturer_id,
                                 category_id: category_id,
                                 color_id: color_id,
                                 search_category_id: search_category_id)

        # Создаем прайс
        Type.all.each do |t|
          (l["Price"].nil?)? price = 0 : price = l["Price"][/[0-9.,]*/]
          (l["Discount"].nil?)? discount = 0 : discount = l["Discount"][/[0-9.,]*/]
          Price.create(type_id: t.id, catalog_id: catalog.id, price: price, discount: discount)
        end

        # Обрабатываем сортовой состав
        wine_variety = l["WineVariety"].strip unless l["WineVariety"].nil?
        unless wine_variety.nil?
          wine_variety.split(',').each do |s|
            str_ = s.strip.gsub(" %","")
            str_a = str_[/[0-9.,]*%/]
            str_a.nil? ? str_a = 100 : str_a.gsub("%", "")
            str_z = str_.gsub(/[0-9.,]*%/, "").strip
            (w_v = WineVariety.create(name: str_z)) if WineVariety.where('name = ?', str_z).first.nil?
            CatalogWineVariety.create(catalog_id: catalog.id, wine_variety_id: w_v.id, percent: str_a) unless w_v.nil?
          end
        end

      end
    end

    redirect_to(root_path)
  end
end
