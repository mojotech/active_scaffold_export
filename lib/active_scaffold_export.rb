require 'fastercsv'
require 'active_scaffold' rescue nil
# Make sure that ActiveScaffold has already been included
ActiveScaffold rescue throw "should have included ActiveScaffold plug in first.  Please make sure that this plug-in comes alphabetically after the ActiveScaffold plug-in"

# Load our overrides
require "#{File.dirname(__FILE__)}/active_scaffold_export/config/core.rb"
require "#{File.dirname(__FILE__)}/active_scaffold/helpers/view_helpers_override.rb"

module ActiveScaffold
  module Actions
    autoload :Export, "active_scaffold/actions/export"
  end

  module Config
    autoload :Export, "active_scaffold/config/export"
  end

  module Helpers
    autoload :ExportHelpers, "active_scaffold/helpers/export_helpers"
  end
end

##
## Run the install script, too, just to make sure
## But at least rescue the action in production
##
Rails::Application.initializer("active_scaffold_export_install_assets") do
  begin
    ActiveScaffold.install_assets_from(File.dirname(__FILE__) + "/..")
  rescue
    raise $! unless Rails.env == 'production'
  end
end

# Register our helper methods
ActionView::Base.send(:include, ActiveScaffold::Helpers::ExportHelpers)
