class ExportTosController < ApplicationController
  def index
    @catalog = Catalog.all
    respond_to do |format|
      format.html
      format.csv { send_data @catalog.to_csv }
      # format.xls { send_data @catalog.to_csv(col_sep: "\t") }
      format.xls
    end
  end
  def show

    # xlsx
    if params[:format] == 'xlsx'
      p = Axlsx::Package.new
      p.workbook do |wb|


        wb.styles do |s|
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


          wb.add_worksheet(:name => "Image with Hyperlink") do |sheet|

            catalog = Catalog.all

            counts ||= 0
            catalog.each do |cg|

              img = cg.avatar.path.nil? ? nil : File.expand_path(cg.avatar.path)

              sheet.add_row ["", cg.name, cg.name_original, cg.description, cg.barcode]

              sheet.rows.last.height=77
              sheet.rows.last.style = wrap_text

              # sheet.column_widths 7.2, 25, 25, 75

              sheet.column_info[0].width = 6
              sheet.column_info[1].width = 25
              sheet.column_info[2].width = 25
              sheet.column_info[3].width = 75

              sheet.add_image(:image_src => img, :noSelect => true, :noMove => true,  :hyperlink=>"http://google.ru") do |image|
                image.width=40
                image.height=100
                image.hyperlink.tooltip = "Labeled Link"
                image.start_at 0, counts
              end
              counts += 1

            end

            # img = File.expand_path('../../../public/system/catalogs/avatars/000/000/001/original/JOIA_work_09_glavnaya-10.jpg', __FILE__)
            # sheet.add_row ['col 1', 'col 2', 'col 3', 'col 4']
            # sheet.rows.last.height=100
            # sheet.add_image(:image_src => img, :noSelect => true, :noMove => true,  :hyperlink=>"http://axlsx.blogspot.com") do |image|
            #   image.width=40
            #   image.height=100
            #   image.hyperlink.tooltip = "Labeled Link"
            #   image.start_at 5, 0
            # end
            # sheet.add_row ['col 1', 'col 2', 'col 3', 'col 4', 'col 5', 'col 6'], :style=>wrap_text
            # sheet.rows.last.height=100
            # sheet.add_image(:image_src => img, :noSelect => true, :noMove => true,  :hyperlink=>"http://axlsx.blogspot.com") do |image|
            #   image.width=40
            #   image.height=100
            #   image.hyperlink.tooltip = "Labeled Link"
            #   image.start_at 5, 1
            # end
            # sheet.add_row ['col 1', 'col 2', 'col 3', 'col 4', 'col 5', 'col 6'], :style=>wrap_text
            # sheet.rows.last.height=100
            # sheet.add_image(:image_src => img, :hyperlink=>"http://axlsx.blogspot.com") do |image|
            #   image.width=40
            #   image.height=100
            #   image.hyperlink.tooltip = "Labeled Link"
            #   image.start_at 5, 2
            # end

          end

        end
      end
      p.serialize '/tmp/catalog.xlsx'

    #PDF
    else
      pdf = Prawn::Document.new
      pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"

      catalog = Catalog.all.limit(20)

      items = [[ "Фото", "Наименоние", "Описание"]]

      items += catalog.map do |item|
        unless item.avatar.path.nil?
          [
            {:image => item.avatar.path},
            item.name,
            item.description
          ]
        else
          [
            "",
            item.name,
            item.description
          ]
        end
      end

      pdf.table(items, header: true) do
        column(0).width = 42
        headers = true
        align = { 0 => :center, 1 => :center, 2 => :right, 3 => :right }
      end
      pdf.render()

    end

    respond_to do |format|
      format.xlsx { send_file '/tmp/catalog.xlsx' }
      format.pdf do
        send_data pdf.render
      end
    end

  end
end
