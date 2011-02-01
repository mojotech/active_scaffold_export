require 'fastercsv'
# Make sure that ActiveScaffold has already been included
ActiveScaffold rescue throw "should have included ActiveScaffold plug in first.  Please make sure that this plug-in comes alphabetically after the ActiveScaffold plug-in"


# Load our overrides
require "active_scaffold_export/config/core.rb"
require "active_scaffold/helpers/view_helpers_override.rb"

module ActiveScaffoldExport
  def self.root
    File.dirname(__FILE__) + "/.."
  end
end

module ActiveScaffold
  module Actions
    ActiveScaffold.autoload_subdir('actions', self, File.dirname(__FILE__))
  end

  module Config
    ActiveScaffold.autoload_subdir('config', self, File.dirname(__FILE__))
  end

  module Helpers
    ActiveScaffold.autoload_subdir('helpers', self, File.dirname(__FILE__))
  end
end

# Register our helper methods
ActionView::Base.send(:include, ActiveScaffold::Helpers::ExportHelpers)


##
## Run the install assets script, too, just to make sure
## But at least rescue the action in production
##
Rails::Application.initializer("active_scaffold_export.install_assets", :after => "active_scaffold.install_assets") do
  begin
    ActiveScaffoldAssets.copy_to_public(ActiveScaffoldExport.root)
  rescue
    raise $! unless Rails.env == 'production'
  end
end if defined?(ACTIVE_SCAFFOLD_EXPORT_GEM)
