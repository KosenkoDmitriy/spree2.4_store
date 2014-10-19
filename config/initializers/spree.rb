# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  config.currency = "RUB"
  config.currency_symbol_position = "after"
  config.currency_decimal_mark = "."
  config.currency_thousands_separator = " "
  #config.available_locales = [:ru, :en]
  #config.supported_locales = [:ru, :en]
end
#I18n.default_locale = :ru
SpreeI18n::Config.available_locales = [:ru, :en] # displayed on translation forms
SpreeI18n::Config.supported_locales = [:ru, :en] # displayed on frontend select box

Spree.user_class = "Spree::LegacyUser"
