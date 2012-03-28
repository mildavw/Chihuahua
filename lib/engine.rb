module Chihuahua
  # Required for chihuahua.js.erb to be discoverable in the asset pipeline
  class Engine < ::Rails::Engine
    initializer 'chihuahua.initialize' do
      ActiveSupport.on_load(:action_view) do
        include Chihuahua::HelperMethods
      end

      ActiveSupport.on_load(:action_controller) do
        include Chihuahua::ControllerMethods
      end
    end
  end
end