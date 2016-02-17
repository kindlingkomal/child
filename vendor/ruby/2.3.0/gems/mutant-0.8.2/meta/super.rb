Mutant::Meta::Example.add do
  source 'super'

  singleton_mutations
  mutation 'super()'
end

Mutant::Meta::Example.add do
  source 'super()'

  singleton_mutations
  # this is zsuper a totally different node than super()
  mutation 'super'
end

Mutant::Meta::Example.add do
  source 'super(foo, bar)'

  singleton_mutations
  mutation 'super'
  mutation 'super()'
  mutation 'super(foo)'
  mutation 'super(bar)'
  mutation 'super(foo, nil)'
  mutation 'super(foo, self)'
  mutation 'super(nil, bar)'
  mutation 'super(self, bar)'
end
