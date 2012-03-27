module Chihuahua

  class << self
    def reset!
      @enabled_features = nil
    end

    def enabled?(feature)
      enabled_features.include?(feature.to_sym)
    end

    def enable(feature)
      enabled_features << feature.to_sym unless enabled_features.include?(feature.to_sym)
    end

    def disable(feature)
      enabled_features.delete(feature.to_sym)
    end

    def set(feature, flag)
      flag ? enable(feature) : disable(feature)
    end

    def enabled_features
      @enabled_features ||= load_enabled_features_from_yaml_file
    end

    protected

    def environment
      Rails.env
    end

    def load_enabled_features_from_yaml_file
      h = YAML.load_file( File.join(File.dirname(__FILE__), '..', 'config', 'chihuahua.yml') )
      h[ environment ].to_a.map(&:to_sym)
    end
    # def load_enabled_features_from_cms_stringtable
    # def load_enabled_features_from_active_record
  end

  module HelperMethods
    def feature?(nickname)
      Chihuahua.enabled?(nickname)
    end

    # Note that there is also a global js function showFeature() in chihuahua.js.erb
    def feature_js?(nickname)
      Chihuahua.enabled?(nickname) ? 'true' : 'false'
    end
  end

  module ControllerMethods
    def feature?(nickname)
      Chihuahua.enabled?(nickname)
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include Chihuahua::HelperMethods
end

ActiveSupport.on_load(:action_controller) do
  include Chihuahua::ControllerMethods
end

#TODO: add a feature? method useful in models and routes? Or just override Object?