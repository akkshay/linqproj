class LinksController < ApplicationController

  def new
    @user = User.find params[:user_id]
    @link = Link.new
  end

  def create
    @user = User.find params[:user_id]
    @link = Link.create(link_params)
    @link.user_id = params[:user_id]
    @link.points = 0
    if @link.save!
      redirect_to root_path
    else
      render "new"
    end
  end

  def pre_send
    @link = Link.find(params[:link_id])
    @sender = User.find(params[:sender_id])
    @username = params[:username]
  end 

  def send_link
    @users = User.all
    @link = Link.find(params[:link_id])
    @sender = User.find(params[:sender_id])
    @users.each do |u|
      if u.name == params[:username]
        @user = u
        break
      end
    end  
    if not @user
      redirect_to root_path
    else
      #@user = User.find(params[:sender_id])
      if not @link.receivers
        @link.receivers =[]
      end
      if not @user.received
        @user.received = []
      end
      if not @user.received.include?(@link.id)
        @link.receivers.push([@user.id, @sender.id])
        @user.received.push(@link.id)
        @link.points = @link.points + 10
      end
      if @link.save! and @user.save!
        redirect_to root_path
      else
        render "new"
      end
    end
  end

  def edit
    @link = Link.find params[:id]
  end

#  def update
 #   @link = Link.find params[:id]
  #  if @link.update link_params
   #   redirect_to @link.user
    #end
  #end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end