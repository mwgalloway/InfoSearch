
20.times { Page.create(url: Faker::Internet.url, title: Faker::Company.buzzword) }

100.times { Word.create(text: Faker::Company.buzzword) }

100.times { Word.create(text: Faker::Name.first_name) }

100.times { Word.create(text: Faker::Name.last_name) }

1000.times { Metric.create(page_id: rand(1..20), word_id: rand(1..300), first_position: rand(1..100), frequency: rand(1..100)) }
