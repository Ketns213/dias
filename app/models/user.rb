class User

  include Dynamoid::Document

  field :name
  field :email
  field :password
  field :age, :integer
  field :hash, :serialized

  has_many :addresses

  index :name
  index :email
  index [:name, :email]
  index :created_at, :range => true

  validates_presence_of :name
  validates_format_of :email, :with => /@/

  before_save :set_defaults
  after_destroy :delete_addresses

  def set_defaults
    self.age = 21
    self.password='P@ssw0rd123'
  end

  def delete_addresses
    addresses.each { |address|
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

