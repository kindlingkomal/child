# -*- encoding: utf-8 -*-
# stub: paloma 4.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "paloma"
  s.version = "4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Karl Paragua"]
  s.date = "2015-09-01"
  s.description = "Page-specific javascript for Rails done right"
  s.email = "kb.paragua@gmail.com"
  s.homepage = "https://github.com/kbparagua/paloma"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Provides an easy way to execute page-specific javascript for Rails."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 3.2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.0"])
      s.add_development_dependency(%q<capybara>, ["~> 1.0"])
      s.add_development_dependency(%q<jasmine-rails>, ["~> 0.4.5"])
      s.add_development_dependency(%q<turbolinks>, ["~> 2.2.2"])
      s.add_development_dependency(%q<execjs>, ["~> 2.1.0"])
    else
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.0"])
      s.add_dependency(%q<capybara>, ["~> 1.0"])
      s.add_dependency(%q<jasmine-rails>, ["~> 0.4.5"])
      s.add_dependency(%q<turbolinks>, ["~> 2.2.2"])
      s.add_dependency(%q<execjs>, ["~> 2.1.0"])
    end
  else
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.0"])
    s.add_dependency(%q<capybara>, ["~> 1.0"])
    s.add_dependency(%q<jasmine-rails>, ["~> 0.4.5"])
    s.add_dependency(%q<turbolinks>, ["~> 2.2.2"])
    s.add_dependency(%q<execjs>, ["~> 2.1.0"])
  end
end
