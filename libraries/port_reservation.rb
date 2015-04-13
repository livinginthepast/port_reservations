module PortReservation
  extend Chef::DSL::DataQuery

  class MissingReservation < StandardError; end

  class << self
    def for(type)
      reservations[type].tap do |reservation|
        raise MissingReservation.new("No port reservation found for #{type}") if reservation.nil?
      end
    end

    def reservations
      @reservations ||= data_bag_item('ports', 'reservations')['mapping']
    end
  end
end
