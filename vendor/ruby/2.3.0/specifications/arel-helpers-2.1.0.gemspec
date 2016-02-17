# -*- encoding: utf-8 -*-
# stub: arel-helpers 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "arel-helpers"
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Cameron Dutro"]
  s.date = "2015-01-13"
  s.description = "Useful tools to help construct database queries with ActiveRecord and Arel."
  s.email = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"
  s.rubygems_version = "2.5.1"
  s.summary = "Useful tools to help construct database queries with ActiveRecord and Arel."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["< 5", ">= 3.1.0"])
    else
      s.add_dependency(%q<activerecord>, ["< 5", ">= 3.1.0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["< 5", ">= 3.1.0"])
  end
end
