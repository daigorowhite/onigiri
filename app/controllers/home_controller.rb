# cording: utf-8
require 'digest/sha1'

class HomeController < ApplicationController
  def index
    @users = User.all
  end


end
