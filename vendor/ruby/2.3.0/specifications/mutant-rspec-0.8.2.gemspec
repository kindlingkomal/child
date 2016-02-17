# -*- encoding: utf-8 -*-
# stub: mutant-rspec 0.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "mutant-rspec"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Markus Schirp"]
  s.date = "2015-08-11"
  s.description = "Rspec integration for mutant"
  s.email = ["mbj@schirp-dso.com"]
  s.extra_rdoc_files = ["TODO", "LICENSE"]
  s.files = ["LICENSE", "TODO"]
  s.homepage = "https://github.com/mbj/mutant"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Rspec integration for mutant"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mutant>, ["~> 0.8.2"])
      s.add_runtime_dependency(%q<rspec-core>, ["< 3.4.0", ">= 3.2.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
    else
      s.add_dependency(%q<mutant>, ["~> 0.8.2"])
      s.add_dependency(%q<rspec-core>, ["< 3.4.0", ">= 3.2.0"])
      s.add_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
    end
  else
    s.add_dependency(%q<mutant>, ["~> 0.8.2"])
    s.add_dependency(%q<rspec-core>, ["< 3.4.0", ">= 3.2.0"])
    s.add_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
  end
end
