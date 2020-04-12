class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end


  def send_invite
    @friend = Friend.where("(user_id = #{current_user.id} and friend_id = #{params[:friend_id]} ) or (user_id = #{params[:friend_id]} and friend_id = #{current_user.id})").first
    if @friend.nil?
      @friend = Friend.new(params_permit_friend)
      @friend.user_id = current_user.id
    end 
    if @friend.present?
      flash[:notice] = 'Friend request already sent'
    elsif @friend.save
      flash[:notice] = 'Friend request sent sucessfully'
    else
      flash[:notice] = 'Sorry not able to send request now'
    end
    redirect_to friends_path
  end

  def friend_request
    user_ids = Friend.where("(friend_id = ? or user_id = ?) and status = ?", current_user.id, current_user.id,'pending').pluck('user_id')
    if user_ids.present?
      @friends = User.where(id: user_ids)
    else
      @friends = []
    end
  end

  def my_friends
    user_ids = Friend.where(friend_id: current_user.id, status: 'accepted').pluck('user_id')
    if user_ids.present?
      @friends = User.where(id: user_ids)
    else
      @friends = []
    end
  end

  def accept_invite
    @friend = Friend.where(friend_id: current_user.id, user_id: params[:user_id]).first
    if @friend.accepted! 
      flash[:notice] = 'friend request accepted'
      redirect_to my_friends_path and return
    else
      flash[:notice] = 'friend request not accepted'
      redirect_to friend_request_path
    end
  end

  def cancel_invite
    @friend = Friend.where(friend_id: current_user.id, user_id: params[:user_id]).first
    if @friend.rejected! 
      flash[:notice] = 'friend request cancelled'
      redirect_to my_friends_path and return
    else
      flash[:notice] = 'unable to cancel friend request'
      redirect_to friend_request_path
    end
  end

  private

  def params_permit_friend
    params.permit(:friend_id)
  end

end
