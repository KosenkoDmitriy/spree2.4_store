# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Spree::Store.all.each do |store|
#  SpreeMultiTenant.with_tenant(store) do
#    Spree::Core::Engine.load_seed if defined?(Spree::Core)
    #Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
#  end
#end

stores=[
    #{:url => "127.0.0.1", code:"127.0.0.1", name:"127.0.0.1", mail_from_address:"dev@shopomob.ru", default_currency:"RUB"},
    {:url => "localhost", code:"localhost", name:"localhost", mail_from_address:"localhost@shopomob.ru", default_currency:"RUB"},
    {:url => "demo.shopomob.ru", code:"demo.shopomob.ru", name:"demo.shopomob.ru", mail_from_address:"shopomob@shopomob.ru", default_currency:"RUB"}
]
stores.each do |store|
  store = Spree::Store.find_or_create_by!(store)
end

Spree::Store.all.each do |store|
  SpreeMultiTenant.with_tenant(store) do
    admin=Spree::User.find_by(email:store.mail_from_address)
    if admin.blank?
      admin=Spree::User.create!(email:store.mail_from_address, password:"123123")
      admin.spree_roles.create!(:name => "admin")
    end

    #user=Spree::User.find_by(email:"bond-007-89@mail.ru")
    #if user.blank?
    #  user=Spree::User.create!(email:"bond-007-89@mail.ru", password:"123123")
    #end

    country=Spree::Country.create!(name:"Россия",iso:"RU",iso3:"RUS",iso_name:"Russian Federation")
    state=Spree::State.create!(name:"РСО Северная Осетия-Алания", country:country)


    #Spree::Config[:currency] = "RUB"
    #Spree::Config[:currency_symbol_position] = "after"
    #Spree::Config[:currency_decimal_mark] = "."
    #Spree::Config[:currency_thousands_separator] = " "
    #default_shipping_category = Spree::ShippingCategory.find_or_create_by!({name:"Самовывоз"})
    #Spree::Product.find_or_create_by!({name:"product1", price:10.0, shipping_category:default_shipping_category})


    russian_zone = Spree::Zone.find_or_create_by!(name:"Россия")
    russian_zone.members.create!(zoneable:Spree::State.first)
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



    Spree::PaymentMethod::Check.find_or_create_by!(
        {
            :name => "Наличными",
            :description => "Оплата наличными",
            :active => true,
        }
    )
  end
end

#Spree::Store.all.each do |store|
#  SpreeMultiTenant.with_tenant(store) do
#    shipping_category = Spree::ShippingCategory.find_or_create_by!({name:"По умолчанию"})
#
#    [{
#         store:store, name:"продукт", price:100, shipping_category:shipping_category, :description => "описание продукта 1", :available_on => Time.zone.now
#    },
#     {
#         store:store, name:"продукт", price:100, shipping_category:shipping_category, :description => "описание продукта 1", :available_on => Time.zone.now
#     },
#    ].each do |product|
#      Spree::Product.create!(product)
#      #p.store = store
#      #p.save
#    end
#  end
#end