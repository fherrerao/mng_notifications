class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[update destroy]

  def index
    @notifications = current_user.notifications
    render json: @notifications
  end

  def create
    @notification = current_user.notifications.build(notification_params)
    if @notification.save
      NotificationSenderService.call(@notification)
      render json: @notification, status: :created
    else
      render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy
    head :no_content
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Notification not found' }, status: :not_found
  end

  def notification_params
    params.require(:notification).permit(:title, :content, :channel, :recipient)
  end
end
