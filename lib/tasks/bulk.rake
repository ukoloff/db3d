namespace :db do
  desc 'Нагенерировать инструментов'
  task bulk: :environment do
    require 'ru_propisju'
    langs = %i(ru ua)
    note = ERB.new File.read Rails.root + 'app/views/bulk/note.txt.erb'
    blob = ERB.new File.read Rails.root + 'app/views/bulk/foto.html.erb'
    (1..100).each do |i|
      t = Tool.new name: "##{i}"
      d = Date.today + i
      t.date = d if 0 != d.wday
      t.note = note.result(binding).strip
      t.create_foto mime: "text/html",
        name: "#{i}.html",
        blob: blob.result(binding).strip
      t.save
    end
  end
end
