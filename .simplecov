SimpleCov.start do
  add_filter '/spec/'
  add_group "lib", "lib"

  minimum_coverage 95.5
end
