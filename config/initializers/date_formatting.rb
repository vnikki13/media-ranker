# https://coreyward.svbtle.com/consistent-date-formatting-in-ruby-on-rails-5
Date::DATE_FORMATS[:default] = "%B %d, %Y"

module FixDateFormatting
  class EasyDate < ActiveRecord::Type::Date
    def cast_value(value)
      default = super
      parsed = Chronic.parse(value)&.to_date if value.is_a?(String)
      parsed || default
    end
  end

  def inherited(subclass)
    super
    date_attributes = subclass.attribute_types.select { |_, type| ActiveRecord::Type::Date === type }
    date_attributes.each do |name, _type|
      subclass.attribute name, EasyDate.new
    end
  end
end

Rails.application.config.to_prepare do
  ApplicationRecord.extend(FixDateFormatting)
end