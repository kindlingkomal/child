# -*- encoding: utf-8 -*-
# stub: active_model_serializers 0.10.0.rc3 ruby lib

Gem::Specification.new do |s|
  s.name = "active_model_serializers"
  s.version = "0.10.0.rc3"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Steve Klabnik"]
  s.date = "2015-09-16"
  s.description = "ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner."
  s.email = ["steve@steveklabnik.com"]
  s.homepage = "https://github.com/rails-api/active_model_serializers"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.5.1"
  s.summary = "Conventions-based JSON generation for Rails."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 4.0"])
      s.add_runtime_dependency(%q<actionpack>, [">= 4.0"])
      s.add_runtime_dependency(%q<railties>, [">= 4.0"])
      s.add_development_dependency(%q<kaminari>, ["~> 0.16.3"])
      s.add_development_dependency(%q<will_paginate>, [">= 3.0.7", "~> 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<timecop>, ["~> 0.7"])
    else
      s.add_dependency(%q<activemodel>, [">= 4.0"])
      s.add_dependency(%q<actionpack>, [">= 4.0"])
      s.add_dependency(%q<railties>, [">= 4.0"])
      s.add_dependency(%q<kaminari>, ["~> 0.16.3"])
      s.add_dependency(%q<will_paginate>, [">= 3.0.7", "~> 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<timecop>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 4.0"])
    s.add_dependency(%q<actionpack>, [">= 4.0"])
    s.add_dependency(%q<railties>, [">= 4.0"])
    s.add_dependency(%q<kaminari>, ["~> 0.16.3"])
    s.add_dependency(%q<will_paginate>, [">= 3.0.7", "~> 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<timecop>, ["~> 0.7"])
  end
end
