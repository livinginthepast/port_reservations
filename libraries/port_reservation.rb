module PortReservation
  extend Chef::DSL::DataQuery

  class << self
    def for(type)
      reservations[type]
    end

    def reservations
      @reservations ||= data_bag_item('ports', 'reservations')['mapping']
    end
  end
end
