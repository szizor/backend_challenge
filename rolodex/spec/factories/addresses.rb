# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :address do |f|
  f.contact_id {1}
  f.address {Factory.next :random_string}
  f.zip {"94587"}
  f.city {Factory.next :random_string}
  f.state {Factory.next :random_string}
  f.country {Factory.next :random_string}
  f.association :address_type, :factory => :address_type
end
