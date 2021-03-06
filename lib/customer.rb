require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = CSV.read('data/customers.csv').map { |row| row.to_a }

    all_customers = all_customers.map do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      Customer.new(id, email, address)
    end

    return all_customers
  end

  def self.find(id)
    customer_found = self.all.select { |customer| customer.id == id }
    customer_found.empty? ? (return nil) : (return customer_found[0])
  end

  def self.save(filename, new_customer)
    new_customer = [
        new_customer.id,
        new_customer.email,
        new_customer.address.values[0],
        new_customer.address.values[1],
        new_customer.address.values[2],
        new_customer.address.values[3]
    ]

    CSV.open(filename, "w") { |csv| csv << new_customer }

    return true
  end
end