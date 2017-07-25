class ShipmentDecorator < SimpleDelegator
  def format_with_active_shipment_count
    {
      id: id,
      name: name,
      # FIXME n+1 querie :(
      # Prolly either using a counter cache or precount with group and find by hash
      products: shipment_products.map { |r| calculate_count(r) }
    }
  end

  private
  def calculate_count(shipment_product)
    record = shipment_product.product.as_json
    record.merge(quantity: shipment_product.quantity,
                 active_shipment_count: shipment_product.product.shipments.count)
  end
end
