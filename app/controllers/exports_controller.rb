class ExportsController < ApplicationController

  def offer

    unless session[:order].nil?
      order = session[:order]
      arr_id = Array.new
      order.each_key do |key|
        arr_id << key
      end
      catalog = Catalog.where('id in (?)', arr_id)
    end

    # params[:format] = params[:foo]
    foo = params[:foo]
    # xlsx
    if foo == 'xlsx'
      p = Axlsx::Package.new
      p.workbook do |wb|

        wb.styles do |s|

          head      = s.add_style :fg_color=> "FFFFFF",
                                  :bg_color => "ff6600",
                                  :sz => 16,
                                  :alignment => { :horizontal => :left,
                                                  :vertical => :center ,
                                                  :wrap_text => true}

          head_date = s.add_style :fg_color=> "FFFFFF",
                                  u: true,
                                  b: true,
                                  :bg_color => "ff6600",
                                  :sz => 10

          text_bold = s.add_style b: true,
                                  :sz => 12

          text      = s.add_style :sz => 10,
                                  :alignment => { :horizontal => :left,
                                                  :vertical => :center ,
                                                  :wrap_text => true}

          wrap_text = s.add_style :alignment => { :horizontal => :center,
                                                  :vertical => :center ,
                                                  :wrap_text => true}
          wrap_text2 = s.add_style :fg_color=> "FFFFFF",
                                   :b => true,
                                   :bg_color => "004586",
                                   :sz => 12,
                                   :border => { :style => :thin, :color => "00" },
                                   :alignment => { :horizontal => :center,
                                                   :vertical => :center ,
                                                   :wrap_text => true}
          wb.add_worksheet(:name => "KP") do |sheet|
            # Формирование заголовка
            sheet.add_row [ Date.today.to_date.to_s, "", "", "" ]
            sheet.rows.last.style = head_date

            # Вставляем картинку
            img = File.absolute_path("../../../public/img/logo.png", __FILE__)
            sheet.add_image(:image_src => img, :noSelect => true, :noMove => true,  :hyperlink=>"http://google.ru") do |image|
              image.width=90
              image.height=90
              image.hyperlink.tooltip = "Labeled Link"
              image.start_at 2, 0
            end

            sheet.add_row [ "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.add_row [ params[:title], "", "", "" ]
            sheet.rows.last.style = head
            sheet.add_row [ "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.merge_cells("A1:B1")
            sheet.merge_cells("A3:B4")
            sheet.add_row [ "", "", "", "" ]

            # sheet.add_row [ "", "Scegliere un vino и un’operazione complessa e sempre diversa da se stessa. Entrano in gioco fattori a cui non si puт essere preparati.", "", "" ]
            # sheet.rows.last.style = text
            # sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "ПРЕДМЕТ:", "", "" ]
            sheet.rows.last.style = text_bold

            params[:description].each_key { |key|
              unless params[:description][key].length < 7
                sheet.add_row [ "", params[:description][key], "", "" ]
                sheet.rows.last.style = text
              end
            }

            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "Коммерческие условия", "", "" ]
            sheet.rows.last.style = text_bold

            params[:offer].each_key { |key|
              unless params[:offer][key].length < 7
                sheet.add_row [ "", params[:offer][key], "", "" ]
                sheet.rows.last.style = text
              end
            }

            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "ДОПОЛНИТЕЛНЫЙ СЕРВИС:", "", "" ]
            sheet.rows.last.style = text_bold

            params[:add_service].each_key { |key|
              unless params[:add_service][key].length < 7
                sheet.add_row [ "", params[:add_service][key], "", "" ]
                sheet.rows.last.style = text
              end
            }

            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "ПОДПИСЬ:", "", "" ]
            sheet.rows.last.style = text_bold
            sheet.add_row [ "", params[:name], "", "" ]
            sheet.add_row [ "", params[:post], "", "" ]
            sheet.add_row [ "", "JSC 'Nesco Saint-Petersburg'", "", "" ]
            sheet.add_row [ "", params[:tel], "", "" ]
            sheet.add_row [ "", "", "", "" ]
            sheet.add_row [ "", "", "", "" ]

            sheet.column_widths 6,89,16,11
          end

          wb.add_worksheet(:name => "Image with Hyperlink") do |sheet|

            # Формирование заголовка
            sheet.add_row [ Date.today.to_date.to_s, "", "", "", "", "", "", "", "", "" ]
            sheet.rows.last.style = head_date
            sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.add_row [ params[:title], "", "", "", "", "", "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]
            sheet.rows.last.style = head
            sheet.merge_cells("A1:H1")
            sheet.merge_cells("A3:H4")
            sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]

            # Наименование колонок
            # description, wine_varieties, honors, abv, barcode, amount
            if params[:name] == 'on'
              sheet.add_row [ "фото", "название", "описание", "сортовой состав", "Награды", "Крепость", "Специальные условия", "Примечание", "Штрих-код", "Количество в упаковке" ]
            else
              sheet.add_row [ "", "название", "описание", "сортовой состав", "Награды", "Крепость", "Специальные условия", "Примечание", "Штрих-код", "Количество в упаковке" ]
            end
            sheet.add_row [ "", "", "", "", "", "", "", "" "", "" ]

            # Номер текущей строки
            row = 9

            # catalog = Catalog.all

            catalog.each do |cg|

              # Подготовка данных
              wine_varieties = ""
              CatalogWineVariety.where('catalog_id = ?', cg.id).each do |c_wv|
                wine_varieties += WineVariety.find(c_wv.wine_variety_id).name + ":" + c_wv.percent.to_s + '% '
              end
              price = Price.where('catalog_id = ? and type_id = ?', cg.id, 1).first.price.to_s + " руб."
              sugar = (cg.sugar_id.nil?) ? " " : Sugar.find(cg.sugar_id).name
              color = cg.color_id.nil? ? "" : Color.find(cg.color_id).name
              manufacturer = cg.manufacturer_id.nil? ? "" : Manufacturer.find(cg.manufacturer_id).name

              # Новая строка с данными
              sheet.add_row ["", cg.name, cg.description, wine_varieties, cg.honors, cg.abv.to_s + "%", "", "", "`" + cg.barcode.to_s, cg.amount ]
              sheet.rows.last.height=15
              sheet.rows.last.style = text
              sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]
              sheet.rows.last.height=15
              sheet.rows.last.style = text
              sheet.add_row [ "", sugar + color, "", "", "", "", "", "", "", "" ]
              sheet.rows.last.height=15
              sheet.rows.last.style = text
              sheet.add_row [ "", manufacturer, "", "", "", "", "", "", "", "" ]
              sheet.rows.last.height=15
              sheet.rows.last.style = text
              sheet.add_row [ "", "", "", "", "", "", "", "", "", "" ]
              sheet.rows.last.height=15

              sheet.merge_cells("B"+(row).to_s+":B"+(row+1).to_s)
              sheet.merge_cells("C"+(row).to_s+":C"+(row+3).to_s)

              if params[:photo] == 'on'
                # Вставляем картинку
                img = cg.avatar.path.nil? ? nil : File.expand_path(cg.avatar.path)
                sheet.add_image(:image_src => img, :noSelect => true, :noMove => true,  :hyperlink=>"http://google.ru") do |image|
                  image.width=40
                  image.height=80
                  image.hyperlink.tooltip = "Labeled Link"
                  image.start_at 0, row - 1
                end
              end

              row += 5

            end

            # Выставляем ширину колонок
            sheet.column_widths 6,32,75,20,20,8,16,11

            # Скрываем колонки
            sheet.column_info[1].hidden   = :true unless params[:nameCheck] == 'on'
            sheet.column_info[2].hidden   = :true unless params[:descriptionCheck] == 'on'
            sheet.column_info[3].hidden   = :true unless params[:wine_varieties] == 'on'
            sheet.column_info[4].hidden   = :true unless params[:honors] == 'on'
            sheet.column_info[5].hidden   = :true unless params[:abv] == 'on'
            sheet.column_info[6].hidden   = :true unless params[:specials] == 'on'
            sheet.column_info[7].hidden   = :true unless params[:note] == 'on'
            sheet.column_info[8].hidden   = :true unless params[:barcode] == 'on'
            sheet.column_info[9].hidden   = :true unless params[:amount] == 'on'
          end

        end
      end
      p.serialize '/tmp/catalog.xlsx'

      # redirect_to :action => "index"

    # PDF
    elsif foo == 'pdf'
      # pdf = Prawn::Document.new
      # pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
      #
      # catalog = Catalog.all.limit(20)
      #
      # items = [[ "Фото", "Наименоние", "Описание"]]
      #
      # items += catalog.map do |item|
      #   unless item.avatar.path.nil?
      #     [
      #       {:image => item.avatar.path},
      #       item.name,
      #       item.description
      #     ]
      #   else
      #     [
      #       "",
      #       item.name,
      #       item.description
      #     ]
      #   end
      # end
      #
      # pdf.table(items, header: true) do
      #   column(0).width = 42
      #   headers = true
      #   align = { 0 => :center, 1 => :center, 2 => :right, 3 => :right }
      # end
      # pdf.render()

      $name = params[:title]

    else
      puts "}{yu BouHe!"
    end

    if params[:format] == "xml"

      # aaa = Array.new

      # Catalog.all.each do |row|
      #   bbb = Hash.new
      #
      #   bbb['id'] = row.id
      #   bbb['name'] = row.name
      #   bbb['name_eng'] = row.name_eng
      #   bbb['description'] = row.description
      #   bbb['description_eng'] = row.description_eng
      #   bbb['abv'] = row.abv
      #   bbb['volume'] = row.volume
      #   bbb['amount'] = row.amount
      #   bbb['honors'] = row.honors
      #   bbb['barcode'] = row.barcode
      #   bbb['hard_liquor'] = row.hard_liquor
      #   bbb['year'] = row.year
      #
      #   sugar = Hash.new
      #   unless row.sugar_id.nil?
      #     s = Sugar.find(row.sugar_id)
      #     sugar['id'] = s.id
      #     sugar['name'] = s.name
      #     sugar['name_eng'] = s.name_eng
      #   end
      #   bbb['sugar'] = sugar
      #
      #   manufacturer = Hash.new
      #   unless row.manufacturer_id.nil?
      #     m = Manufacturer.find(row.manufacturer_id)
      #     manufacturer['id'] = m.id
      #     manufacturer['name'] = m.name
      #     manufacturer['name_eng'] = m.name_eng
      #   end
      #   bbb['manufacturer'] = manufacturer
      #
      #   category = Hash.new
      #   unless row.category_id.nil?
      #     c = Category.find(row.category_id)
      #     category['id'] = c.id
      #     category['name'] = c.name
      #   end
      #   bbb['category'] = category
      #
      #   color = Hash.new
      #   unless row.color_id.nil?
      #     c = Color.find(row.color_id)
      #     color['id'] = c.id
      #     color['name'] = c.name
      #     color['name_eng'] = c.name_eng
      #   end
      #   bbb['color'] = color
      #
      #   price = Hash.new
      #   p = Price.where('catalog_id = ?', row.id)
      #   p.each do |row|
      #     price['type_'+row.type_id.to_s] = row.price
      #     price['discount_'+row.type_id.to_s] = row.discount
      #   end
      #   bbb['price'] = price
      #
      #   bbb['avatar'] = row.avatar.url
      #   bbb['photo_best'] = row.photo_best.url
      #   bbb['photo_original'] = row.photo_original.url
      #
      #   aaa << bbb
      #
      # end

      aaa = Hash.new
      aaa['Catalog']      = Catalog.all.order('weight ASC')
      bbb = Array.new
      Catalog.all.order('weight ASC').each do |row|
        ccc = Hash.new
        ccc['id'] = row.id
        ccc['avatar'] = row.avatar.url
        ccc['photo_best'] = row.photo_best.url
        ccc['photo_original'] = row.photo_original.url
        bbb << ccc
      end
      aaa['Photo']        = bbb
      aaa['Type']         = Type.all
      aaa['Sugar']        = Sugar.all
      aaa['Manufacturer'] = Manufacturer.all
      aaa['Category']     = Category.all
      aaa['Color']        = Color.all
      aaa['Price']        = Price.all
      aaa['WineVariety']  = WineVariety.all
      aaa['CatalogWineVariety'] = CatalogWineVariety.all
      aaa['Country']      = Country.all
      aaa['Region']       = Region.all

    end

    respond_to do |format|
      format.xml { render :xml => aaa }
      format.html {
        if foo == "xlsx"
          send_file '/tmp/catalog.xlsx', :filename => "offer.xlsx"
        elsif foo == "pdf"
          redirect_to '/offers.pdf'
        else

        end
      }
      format.xlsx { send_file '/tmp/catalog.xlsx', :filename => "offer.xlsx" }
      format.pdf do

        # @catalogs = Catalog.all
        @catalogs = catalog

        render :pdf => "file_name",
               :margin => {:top                => 0,
                           :bottom             => 0,
                           :left               => 0,
                           :right              => 0}
      end
    end

  end
end
