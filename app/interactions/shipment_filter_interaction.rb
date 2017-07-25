class ShipmentFilterInteraction
  def initialize(params)
    @params = params
  end

  def perform
    query = build_query
    query = sort(query)
    query = filter(query)
    query = paginate(query)

    query.map { |shipment| ShipmentDecorator.new(shipment).format_with_active_shipment_count }
  end

  private
  def params
    @params
  end

  def build_query
    Shipment.includes(products: [:shipments]).where(company: params[:company_id].to_i)
  end

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

  def sort(query)
    if params[:sort] == 'international_departure_date'.freeze
      query.order(params[:sort] => params[:direction])
    else
      query
    end
  end

  def filter(query)
    if params[:international_transportation_mode]
      query.where(international_transportation_mode: params[:international_transportation_mode])
    else
      query
    end
  end

  def paginate(query)
    query.limit(limit).offset(offset)
  end
end
