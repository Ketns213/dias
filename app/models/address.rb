class Address
  include Dynamoid::Document

  field :street_number
  field :street_name
  field :suburb
  field :city
  field :state
  field :post_code

  belongs_to :user

  def find_addresses_in_city(city, total)
    Address.where(:city => city).limit(total)
  end

end