class UrlExclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || %w[new edit index session login logout users admin
                        stylesheets assets javascripts javascript images].include?(value.downcase)
      record.errors.add attribute, (options[:message] || 'must be a different word.')
    end
  end
end
