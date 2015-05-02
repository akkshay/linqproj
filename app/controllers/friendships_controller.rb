class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @friends = current_user.friends
  end

  def new
    @user = current_user
    @users = User.all
    @invitee = User.new

  end

  def create
    @invitee = User.find_by_name params[:user][:name]
    if @invitee
      if current_user.invite @invitee
        redirect_to root_path, :notice => "Successfully invited friend!"
      else
        redirect_to root_path, :notice => "Sorry! You can't invite that user!"
      end
    else
      redirect_to new_friend_path, :notice => "Sorry! You can't invite that user!"
    end
  end

  def update
    @inviter = User.find params[:id]
    if @inviter
      if current_user.approve @inviter
        redirect_to root_path, :notice => "Successfully confirmed friend!"
      else
        redirect_to new_friend_path, :notice => "Sorry! Could not confirm friend!"
      end
    end
  end

  def requests
    @pending_requests = current_user.pending_invited_by
  end

  def invites
    @pending_invites = current_user.pending_invited
  end

  def delete
    @user = User.find params[:user_id]
    @deleter = current_user
    @deletee = User.new
  end

  def destroy
    @deletee = User.find_by_name params[:user][:name]
    if @deletee
      if current_user.remove_friendship @deletee
        redirect_to friends_path, :notice => "Successfully removed friend!"
      else
        redirect_to friends_path, :notice => "Sorry, couldn't remove friend!"
      end
    end
  end


end