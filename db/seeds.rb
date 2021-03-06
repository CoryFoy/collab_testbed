# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Department.all.count > 0
  Department.transaction do
    ap = Department.create!(:name => "Astrophysics")
    b = Department.create!(:name => "Biology")
    bp = Department.create!(:name => "Biophysics")
    e = Department.create!(:name => "Engineering")
    Venue.create!(:name => "Boston")
    Venue.create!(:name => "World Symposium")
    r1 = Researcher.create!(:name => "Justin Example", :department => ap)
    r2 = Researcher.create!(:name => "William Example", :department => ap)
    r3 = Researcher.create!(:name => "Justine Example", :department => b)
    r4 = Researcher.create!(:name => "Diane Example", :department => b)
    r5 = Researcher.create!(:name => "Marcia Example", :department => bp)
    r6 = Researcher.create!(:name => "Stefan Example", :department => bp)
    r7 = Researcher.create!(:name => "Linda Example", :department => e)
    r8 = Researcher.create!(:name => "Steven Example", :department => e)
    ra1 = ResearchArea.create!(:name => "Pollution")
    ra2 = ResearchArea.create!(:name => "Industrial Management")
    ra3 = ResearchArea.create!(:name => "Energy policy")
    ra4 = ResearchArea.create!(:name => "Microeconomics")
    ra5 = ResearchArea.create!(:name => "Macroeconomics")
    ra6 = ResearchArea.create!(:name => "Wireless Communication Systems")
    ra7 = ResearchArea.create!(:name => "Computers")
    ra8 = ResearchArea.create!(:name => "Life on other planets")
    ra9 = ResearchArea.create!(:name => "Speech processing systems")
    ra10 = ResearchArea.create!(:name => "Electric circuits")
    ra11 = ResearchArea.create!(:name => "Finance")

    word_string = File.open("#{Rails.root}/db/paper_words.txt", 'r') { |f| f.read }
    words = word_string.split(' ')
    word_count = words.count
    researchers = Researcher.all
    rcnt = researchers.count
    areas = ResearchArea.all
    acnt = areas.count

    1000.times do |i|
      title = ""
      7.times do
        title += words[rand(word_count)] + " "
      end
      venue = rand(1) == 0 ? Venue.first : Venue.last
      month = rand(11) + 1
      year = rand(60) + 1950
      day = rand(25) + 1
      pub_date = Date.new(year, month, day)

      p = Publication.create(:name => title, :venue_id => venue.id, :publication_date => pub_date)
      2.times do
        p.researchers << researchers[rand(rcnt)]
      end
      3.times do
        p.research_areas << areas[rand(acnt)]
      end
      p.save
    end

    100.times do |i|
      title = ""
      9.times do
        title += words[rand(word_count)] + " "
      end
      p = Patent.create(:title => title)
      2.times do
        p.researchers << researchers[rand(rcnt)]
      end
      3.times do
        p.research_areas << areas[rand(acnt)]
      end
    end

    300.times do |i|
      title = ""
      3.times do
        title += words[rand(word_count)] + " "
      end
      g = Grant.create(:title => title, :amount => rand(1000000), :date_awarded => DateTime.now)
      2.times do
        g.researchers << researchers[rand(rcnt)]
      end
      3.times do
        g.research_areas << areas[rand(acnt)]
      end

    end


  end
end
