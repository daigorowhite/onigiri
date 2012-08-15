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

      # check url and analyze
      if params[:req][:getFrom] == "url"
        url = params[:req][:url]
        unless url == nil || url == ""
          @source = Source.new
          @source.url = url
          html_val = Core::CommonUtil.get_string_by_url(@source.url)
          unless  html_val == nil
            pre_list = Core::CommonUtil.get_pre_list(html_val)
            unless pre_list == nil
              @source.source = pre_list[0]
              if @source.save
                @source = Source.all.last
              @tmp_comment.source_id = @source.id
              else
                @info = "fail to anylize the url. #{url}"
                render :action => "index.html"
              end
            end
          end
        end
      end

      # check source
      if params[:req][:getFrom] == "source"
        source = params[:req][:source]
        @source = Source.new
        @source.url = nil
        unless  source == nil
          @source.source = source
          if @source.save
            @source = Source.all.last
          @tmp_comment.source_id = @source.id
          else
            @info = "fail to anylize the url. #{url}"
            render :action => "index.html"
          end
        end
      end

      # save commnet
      if @tmp_comment.save
        @info = "Commented"
      else
        @info = "fail to comment"
      end
      render :action => "index.html"
    else
      @info = "fail to comment"
      render :action => "index.html"
    end
  end

  def login

    User.all.each do |tmp|
      @login_user = tmp if tmp[:user_name] == params[:user][:name]
    end

    if @login_user == nil
      @info = "fail to login"
      render :action => "index.html"
    elsif @login_user[:user_password] == Digest::SHA1.hexdigest(params[:user][:password])
      session[:user] = @login_user[:user_name]
      session[:user_id] = @login_user[:id]
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
    session[:user] = nil
    session[:user_id] = nil
    @logined_user = nil

    render :action => "index.html"
  end
end
