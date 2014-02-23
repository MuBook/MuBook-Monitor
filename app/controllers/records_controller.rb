class RecordsController < ApplicationController
  before_action :set_record, only: [:show]

  def index
    @records = Record.all
  end

  def show
  end

  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { head :created }
        format.json { render json: @record }
      else
        Record.create(
          name: 'Monitor',
          email: 'system@mubook.me',
          title: 'Error',
          message: JSON.pretty_generate(record_params)
        )

        head :internal_server_error
      end
    end
  end

  private
    def set_record
      @record = Record.find(params[:id])
    end

    def record_params
      params.require(:record).permit(:name, :email, :title, :message)
    end
end
