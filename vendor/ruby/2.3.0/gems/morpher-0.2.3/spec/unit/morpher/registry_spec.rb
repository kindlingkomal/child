# encoding: UTF-8

require 'spec_helper'

describe Morpher::Registry do

  specify do
    klass = Class.new do
      include Morpher::Registry
      register :foo
    end

    expect(klass::REGISTRY).to eql(foo: klass)
  end
end
