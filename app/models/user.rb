class User

  include Dynamoid::Document

  field :name
  field :email
  field :password
  field :rank, :integer
  field :number, :float
  field :joined_at, :datetime
  field :hash, :serialized

  has_many :addresses

  index :name
  index :email
  index [:name, :email]
  index :created_at, :range => true
  index :name, :range_key => :joined_at

  validates_presence_of :name
  validates_format_of :email, :with => /@/

  before_save :set_default_password
  after_destroy :delete_addresses

  def set_default_password
    password='P@ssw0rd123'
  end

  def delete_addresses
    addresses.each { |address |
      address.delete!
    }
  end

  def created_in_last_day
    User.where("created_at.gt" => DateTime.now - 1.day).all
  end

  def create_before_last_day
    User.where("created_at.lt" => DateTime.now - 1.day).all
  end

end