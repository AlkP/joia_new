class TypesController < ApplicationController
  before_filter :check_admin
  def index
    @types = Type.all
  end
end
