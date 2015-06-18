class NewsAttachmentsController < ApplicationController
  def create
    news_id = params[:news_attachment][:news_id]
    att = NewsAttachment.new
    att.att_file = params[:news_attachment][:file]
    att.news_id = params[:news_attachment][:news_id]
    att.name = att.att_file.original_filename
    att.save

    redirect_to '/news/'+news_id
  end
  def destroy
    att = NewsAttachment.find(params[:id])
    news_id = att.news_id
    att.destroy

    redirect_to '/news/'+news_id.to_s
  end
end
