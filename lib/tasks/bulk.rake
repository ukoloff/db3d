namespace :db do
  desc 'Нагенерировать инструментов'
  task bulk: :environment do
    require 'ru_propisju'
  end
end
