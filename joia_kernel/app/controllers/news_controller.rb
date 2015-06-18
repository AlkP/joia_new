class NewsController < ApplicationController
  before_filter :check_admin, except: [:view_news]
  def view_news # Просмотр новостей всеми
    @news = News.all.order('name ASC')
  end
  def index # Просмотр новостей для редактирования
    @news = News.all.order('name ASC')
  end
  def new
    @news_edit = News.new
    @news_edit.name = "Новая новость"
    @news_edit.save
    @news_att = NewsAttachment.where('news_id = ?', @news_edit)
    @news_att_new = NewsAttachment.new
    render 'show'
  end
  def show
    @news_edit = News.find(params[:id])
    @news_att = NewsAttachment.where('news_id = ?', @news_edit)
    @news_att_new = NewsAttachment.new
  end
  def update
    news = News.find(params[:id])
    news.update(news_params)
  end
  def destroy
    news = News .find(params[:id])
    news.destroy

    redirect_to news_index_path
  end
  private
  def news_params
    params.require(:news).permit( :name, :content )
  end
end
