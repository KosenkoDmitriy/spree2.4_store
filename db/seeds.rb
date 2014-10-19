# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin=Spree::User.find_by(email:"shopomob@shopomob.ru")
if admin.blank?
  admin=Spree::User.create!(email:"shopomob@shopomob.ru", password:"123123")
  admin.spree_roles.create(:name => "admin")
end

user=Spree::User.find_by(email:"bond-007-89@mail.ru")
if admin.blank?
  user=Spree::User.create!(email:"bond-007-89@mail.ru", password:"123123")
end

country=Spree::Country.create!(name:"Россия",iso:"RU",iso3:"RUS",iso_name:"Russian Federation")
state=Spree::State.create(name:"Владикавказ", country:country)

#Spree::Core::Engine.load_seed if defined?(Spree::Core)
#Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

#Spree::Config[:currency] = "RUB"
#Spree::Config[:currency_symbol_position] = "after"
#Spree::Config[:currency_decimal_mark] = "."
#Spree::Config[:currency_thousands_separator] = " "
#default_shipping_category = Spree::ShippingCategory.find_or_create_by!({name:"Самовывоз"})
#Spree::Product.find_or_create_by!({name:"product1", price:10.0, shipping_category:default_shipping_category})


russian_zone = Spree::Zone.find_or_create_by(name:"Россия")
russian_zone.members.create(zoneable:Spree::State.first)
shipping_category = Spree::ShippingCategory.find_or_create_by!({name:"По умолчанию"})
Spree::ShippingMethod.create!([
{
    :name => "Почтой",
    :zones => [russian_zone],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
},
{
    :name => "Такси",
    :zones => [russian_zone],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
},
{
    :name => "Курьером",
    :zones => [russian_zone],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
},
{
    :name => "Поездом",
    :zones => [russian_zone],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
},
{
    :name => "Самолетом",
    :zones => [russian_zone],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
}
])

{
    "Почтой" => [100, "RUB"],
    "Такси" => [150, "RUB"],
    "Курьером" => [150, "RUB"],
    "Поездом" => [70, "RUB"],
    "Самолетом" => [300, "RUB"]
}.each do |shipping_method_name, (price, currency)|
  shipping_method = Spree::ShippingMethod.find_by_name!(shipping_method_name)
  shipping_method.calculator.preferences = {
      amount: price,
      currency: currency
  }
  shipping_method.calculator.save!
  shipping_method.save!
end

products = [
    {
        name:"продукт",price:100, shipping_category:shipping_category,
        :description => "описание продукта 1",
        :available_on => Time.zone.now
    },
]
products.each do |product|
  p = Spree::Product.new(product)
  p.update_attributes(product)
end

Spree::PaymentMethod::Check.create!(
    {
        :name => "Наличными",
        :description => "Оплата наличными",
        :active => true
    }
)