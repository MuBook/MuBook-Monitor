class RecordsController < ApplicationController
  before_action :set_record, only: [:show]

  skip_before_filter :verify_authenticity_token

  rescue_from ActiveRecord::ActiveRecordError, with: :log_error

  def index
    @records = Record.page(params[:page])
  end

  def show
  end

  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save!
        format.html { head :created }
        format.json { render json: @record }
      end
    end
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

      head :internal_server_error
    end

    def set_record
      @record = Record.find(params[:id])
    end

    def record_params
      params.require(:record).permit(:name, :email, :title, :message)
    end
end
