class ChatController < ApplicationController
  before_action :check_and_authenticate_user
  before_action :authenticate_user!
end