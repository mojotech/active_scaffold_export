# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_scaffold_export}
  s.version = "3.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Volker Hochstein", "Mojo Tech, LLC", "see commits"]
  s.date = %q{2011-03-26}
  s.description = %q{This Active Scaffold plugin provides a configurable CSV 'Export' action for Active Scaffold controllers}
  s.email = %q{activescaffold@googlegroups.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "MIT-LICENSE",
    "README.markdown",
    "Rakefile",
    "active_scaffold_export.gemspec",
    "frontends/default/images/export.png",
    "frontends/default/stylesheets/export-stylesheet-ie.css",
    "frontends/default/stylesheets/export-stylesheet.css",
    "frontends/default/views/_export.csv.erb",
    "frontends/default/views/_export_form_body.html.erb",
    "frontends/default/views/_show_export.html.erb",
    "frontends/default/views/show_export.html.erb",
    "init.rb",
    "lib/active_scaffold/actions/export.rb",
    "lib/active_scaffold/config/export.rb",
    "lib/active_scaffold/helpers/export_helpers.rb",
    "lib/active_scaffold_export.rb",
    "lib/active_scaffold_export/config/core.rb",
    "lib/active_scaffold_export/version.rb"
  ]
  s.homepage = %q{http://github.com/mojotech/active_scaffold_export}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Exporting Records with ActiveScaffold}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<active_scaffold_vho>, [">= 3.0.12"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<active_scaffold_vho>, [">= 3.0.12"])
      s.add_dependency(%q<fastercsv>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<active_scaffold_vho>, [">= 3.0.12"])
    s.add_dependency(%q<fastercsv>, [">= 0"])
  end
end

