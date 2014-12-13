class RecordsController < ApplicationController
  before_action :set_record, only: [:show]

  before_filter :set_cross_domain_header, only: [:create]

  skip_before_filter :verify_authenticity_token
  skip_before_filter :login, only: [:create, :production, :testing]

  rescue_from ActiveRecord::ActiveRecordError, with: :log_error

  def index
    @records = Record.page(params[:page])
  end

  def show
  end

  def create
    message = record_params[:message]

    @record = Record.new(
      name: record_params[:name],
      email: record_params[:email],
      title: message[0, 35] + (message.size > 35 ? '...' : ''),
      message: message
    )

    @record.save!
    head :created
  end

  def production
    log_deploy 'Production'
  end

  def testing
    log_deploy 'Testing'
  end

private

  def log_deploy(server)
    Record.create(
      name: 'Monitor',
      email: "#{params['user']}",
      title: "#{params['head']} was deployed to #{server}",
      message: params['git_log']
    )

    Rails.logger.info "New deploy to #{server}"

    head :created
  end

  def log_error
    Record.create(
      name: 'Monitor',
      email: 'monitor@mubook.me',
      title: 'Error',
      message: params.inspect
    )

    Rails.logger.error "Error with request: #{params.inspect}"

    head :bad_request
  end

  def set_cross_domain_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST'
  end

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:name, :email, :title, :message)
  end
end
