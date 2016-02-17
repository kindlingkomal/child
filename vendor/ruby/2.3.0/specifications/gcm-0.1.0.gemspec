# -*- encoding: utf-8 -*-
# stub: gcm 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gcm"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Kashif Rasul", "Shoaib Burq"]
  s.date = "2015-01-15"
  s.description = "gcm is a service that helps developers send data from servers to their Android applications on Android devices."
  s.email = ["kashif@spacialdb.com", "shoaib@spacialdb.com"]
  s.homepage = "https://github.com/spacialdb/gcm"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubyforge_project = "gcm"
  s.rubygems_version = "2.5.1"
  s.summary = "send data to Android applications on Android devices"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
