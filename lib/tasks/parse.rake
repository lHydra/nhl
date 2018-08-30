namespace :parse do
  desc 'parse nhlnumber site and save information to Player model'
  task :nhlnumbers, [:proxy] do |t, args|
    NhlParser.new(proxy: args[:proxy]).parse
  end
end
