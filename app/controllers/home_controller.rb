class HomeController < ApplicationController
  def index
    @comments= Comment.all
    @logined_user = session[:user]
  end

  def add_comment
    @logined_user = session[:user]
    
    @tmp_comment = Comment.new
    comment = params[:req][:comment]
    unless session[:user] == nil || comment == nil || comment.empty?
      @tmp_comment.contents = comment
      @tmp_comment.user_id = session[:user_id]
      @tmp_comment.commented =  Time.now
      if @tmp_comment.save
        @comments = Comment.all
        p "================="
        p @comments
        p "================="
        @info = "Commented"
        render :action => "index.html"
      else
        @comments = Comment.all
        @info = "fail to comment"
        render :action => "index.html"
      end
    else
      @comments = Comment.all
      @info = "fail to comment"
      render :action => "index.html"
    end
  end

  def login
    @comments= Comment.all

    User.all.each do |tmp|
      @login_user = tmp if tmp[:user_name] == params[:user][:name]
    end

    if @login_user == nil
      @info = "fail to login"
      render :action => "index.html"
    elsif @login_user[:user_password] == Digest::SHA1.hexdigest(params[:user][:password])
      session[:user] = @login_user[:user_name]
      session[:user_id] = @login_user[:user_id]
      @logined_user = session[:user]
      @info = "hello " + @login_user[:user_name]
      render :action => "index.html"
    else
      @info = "fail to login"
      render :action => "index.html"
    end
  end

  def logout
      @info = "logout! have a good day!"
    @comments= Comment.all
    session[:user] = nil
    session[:user_id] = nil
    @logined_user = nil

    render :action => "index.html"
  end
end
