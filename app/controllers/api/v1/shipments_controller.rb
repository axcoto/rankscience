class Api::V1::ShipmentsController < ApplicationController
  before_action :require_company_id

  def index
    interaction = ShipmentFilterInteraction.new(shipment_params)

    render json: {records: interaction.perform}
  end

  private
  def shipment_params
    params.permit(:company_id, :international_transportation_mode, :page, :per, :sort, :direction)
  end

  def require_company_id
    if params[:company_id].blank?
      render json: {errors: ['company_id is required']}, status: :unprocessable_entity
    end
  end
end
