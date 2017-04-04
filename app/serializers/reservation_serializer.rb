class ReservationSerializer < ActiveModel::Serializer
  attributes :id,
             :start_date,
             :end_date,
             :status,
             :num_nights,
             :total_cost
end
