namespace :db do
  desc 'Нагенерировать инструментов'
  task :bulk do #:environment do
    require 'ru_propisju'
    (1..100).each do |i|
      print "#{i}=#{RuPropisju.propisju i, 1} "
    end
  end
end
