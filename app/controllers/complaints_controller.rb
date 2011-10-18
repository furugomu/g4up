# -*- encoding: UTF-8 -*-
class ComplaintsController < ApplicationController
  respond_to :html, :json
  before_filter :find_entry

  def index
    @complaint = @entry.complaints.new
  end

  def create
    complaint = @entry.complaints.create(ip_address: ip_address)
    flash[:notice] = '通報しました'
    respond_with @entry
  end

  private

  def ip_address
    request.env['X_FORWARDED_FOR'] || request.env['REMOTE_ADDR']
  end

  def find_entry
    @entry = Entry.find(params[:entry_id])
  end

end
