Factory.sequence :random_string do |n|
  (0...8).map{65.+(rand(25)).chr}.join
end
