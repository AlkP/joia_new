class StoriesController < ApplicationController
  before_filter :check_admin, except: [:view_news]
  def view_news # Просмотр новостей всеми
    @news = Story.all.order('weight ASC')
  end
  def index # Просмотр новостей для редактирования
    @news = Story.all.order('weight ASC')
  end
  def new
    @news_edit = Story.new
    @news_edit.title = "Новая новость"
    @news_edit.save

    render 'show'
  end
  def show
    @news_edit = Story.find(params[:id])
  end
  def update
    news = Story.find(params[:id])
    news.update(stories_params)

    @news_edit = Story.find(params[:id])

  end
  def destroy
    news = Story.find(params[:id])
    news.destroy

    redirect_to stories_path
  end
  def send_story_sortable
    result = JSON.parse(params["arr_region"])
    weight = 0
    result.each do |res|
      Story.find(res['id']).update(weight: weight)
      weight += 1
    end
  end
  private
  def stories_params
    params.require(:story).permit( :title, :intro_text, :large_title, :large_text, :avatar )
  end
end
