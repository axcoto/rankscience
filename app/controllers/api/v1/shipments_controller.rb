class Api::V1::ShipmentsController < ApplicationController
  def index
    if params[:company_id].blank?
      return render json: {errors: ['company_id is required']}, status: :unprocessable_entity
    end

    outcome = case
    when params[:company_id].present?
      query = Shipment.includes(products: [:shipments]).where(company: params[:company_id].to_i)
      
      if params[:sort] == 'international_departure_date'.freeze
        query = query.order(params[:sort] => params[:direction])
      end

      if params[:international_transportation_mode]
        query = query.where(international_transportation_mode: params[:international_transportation_mode])
      end

      query.limit(limit).offset(offset).map do |shipment|
        {
          id: shipment.id,
          name: shipment.name,
          products: shipment.shipment_products.map do |r|
            # FIXME n+1 query :(
            r.product.as_json.merge(quantity: r.quantity, active_shipment_count: r.product.shipments.count)
          end
        }
      end
    end

    render json: {records: outcome}
  end

  private
  def offset
    if params[:page] && params[:page].to_i > 0
      (params[:page].to_i - 1) * limit
    else
      0
    end
  end

  def limit
    (params[:per] || 4).to_i
  end
end
