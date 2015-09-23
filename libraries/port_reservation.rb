module PortReservation
  extend Chef::DSL::DataQuery

  class MissingReservation < StandardError; end
  class AmbiguousReservation < StandardError; end

  class << self
    def for(type)
      ip = reservations[type].tap do |reservation|
        raise MissingReservation.new("No port reservation found for #{type}") if reservation.nil?
        raise AmbiguousReservation.new("port #{reservation} is reserved by multiple services") if ambiguous?(reservation)
      end
      ip.is_a?(String) ? string_to_range(ip) : ip
    end

    def reservations
      @reservations ||= data_bag_item('ports', 'reservations')['mapping']
    end

    def ambiguous?(reservation)
      reservations_count_by_ip[reservation] > 1
    end

    def reservations_count_by_ip
      count_by_ip ||= begin
        count = Hash.new(0)
        reservations.values.each do |res|
          case res
          when String
            string_to_range(res).each do |ip|
              count[ip] += 1
            end
          else
            count[res] += 1
          end
        end
        count
      end
    end

    def string_to_range(string)
      boundaries = string.split('..').map { |d| Integer(d) }
      boundaries[0]..boundaries[1]
    end
  end
end
