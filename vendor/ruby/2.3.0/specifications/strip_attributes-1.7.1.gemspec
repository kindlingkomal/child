# -*- encoding: utf-8 -*-
# stub: strip_attributes 1.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "strip_attributes"
  s.version = "1.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryan McGeary"]
  s.date = "2015-08-24"
  s.description = "StripAttributes automatically strips all ActiveRecord model attributes of leading and trailing whitespace before validation. If the attribute is blank, it strips the value to nil."
  s.email = ["ryan@mcgeary.org"]
  s.homepage = "https://github.com/rmm5t/strip_attributes"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Whitespace cleanup for ActiveModel attributes"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["< 5.0", ">= 3.0"])
      s.add_development_dependency(%q<active_attr>, ["~> 0.7"])
      s.add_development_dependency(%q<minitest-matchers>, ["~> 1.2"])
      s.add_development_dependency(%q<minitest>, ["< 6.0", ">= 4.7"])
      s.add_development_dependency(%q<minitest-reporters>, [">= 0.14.24"])
      s.add_development_dependency(%q<rake>, ["~> 10.1.1"])
    else
      s.add_dependency(%q<activemodel>, ["< 5.0", ">= 3.0"])
      s.add_dependency(%q<active_attr>, ["~> 0.7"])
      s.add_dependency(%q<minitest-matchers>, ["~> 1.2"])
      s.add_dependency(%q<minitest>, ["< 6.0", ">= 4.7"])
      s.add_dependency(%q<minitest-reporters>, [">= 0.14.24"])
      s.add_dependency(%q<rake>, ["~> 10.1.1"])
    end
  else
    s.add_dependency(%q<activemodel>, ["< 5.0", ">= 3.0"])
    s.add_dependency(%q<active_attr>, ["~> 0.7"])
    s.add_dependency(%q<minitest-matchers>, ["~> 1.2"])
    s.add_dependency(%q<minitest>, ["< 6.0", ">= 4.7"])
    s.add_dependency(%q<minitest-reporters>, [">= 0.14.24"])
    s.add_dependency(%q<rake>, ["~> 10.1.1"])
  end
end
