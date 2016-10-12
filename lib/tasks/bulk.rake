namespace :db do
  desc 'Нагенерировать инструментов'
  task bulk: :environment do
    require 'ru_propisju'
    blob = ERB.new File.read Rails.root + 'app/views/bulk/foto.html.erb'
    (1..97).each do |i|
      t = Tool.new name: RuPropisju.propisju(i, 1, :ru),
        author: 'тест',
        creator_id: -42,
        note: RuPropisju.propisju(i, 1, :ua)
      d = Date.today + i
      t.date = d if 0 != d.wday
      t.create_foto mime: "text/html",
        creator_id: -42,
        name: "#{i}.html",
        blob: blob.result(binding).strip
      t.save
    end
  end

  namespace :bulk do
    desc 'Удалить сгенерированные инструменты'
    task clear: :environment do
      Tool.where(creator_id: -42).delete_all
    end
  end
end
