class Listing < ApplicationRecord
  has_many :images
  has_many :reservations
  has_many :user_roles
  belongs_to :user

  validates_presence_of :street_address,
                        :description,
                        :city,
                        :state,
                        :zipcode,
                        :user,
                        :max_occupancy,
                        :number_beds,
                        :number_rooms,
                        :number_baths

  def range_available?(start_date, end_date)
    statuses = (start_date.to_date..end_date.to_date).to_a.map do |date|
      date_available?(date)
    end
    status = statuses.all? { |status| status == true }
  end

  def date_available?(date)
    check_start_and_end_dates(date.to_date) && check_middle_dates(date.to_date)
  end

  def check_start_and_end_dates(date)
    reservations.where(start_date: date).count == 0 && reservations.where(end_date: date).count == 0
  end

  def check_middle_dates(date)
    reservations.where('end_date >= ? AND start_date <= ?', date, date).count == 0
  end
end
