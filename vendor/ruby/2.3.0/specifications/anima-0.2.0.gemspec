# -*- encoding: utf-8 -*-
# stub: anima 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "anima"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Markus Schirp"]
  s.date = "2014-01-13"
  s.email = "mbj@schirp-dso.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/mbj/anima"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Initialize object attributes via attributes hash"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<adamantium>, ["~> 0.1"])
      s.add_runtime_dependency(%q<equalizer>, ["~> 0.0.8"])
      s.add_runtime_dependency(%q<abstract_type>, ["~> 0.0.7"])
    else
      s.add_dependency(%q<adamantium>, ["~> 0.1"])
      s.add_dependency(%q<equalizer>, ["~> 0.0.8"])
      s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
    end
  else
    s.add_dependency(%q<adamantium>, ["~> 0.1"])
    s.add_dependency(%q<equalizer>, ["~> 0.0.8"])
    s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
  end
end
