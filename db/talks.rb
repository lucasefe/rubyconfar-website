# Day 1

Talk.create(:title_en => "Welcome to RubyConf Argentina 2011!", 
  :title_es => "Bienvenida a RubyConf Argentina 2011!", 
  :starts_at => Time.parse("2011-11-8 9:00"),
  :ends_at => Time.parse("2011-11-8 9:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','RubyConfAr').id)

Talk.create(:title_en => "Ruby's past, present, and future", 
  :title_es => "Pasado presente y futuro de Ruby", 
  :starts_at => Time.parse("2011-11-8 9:20"),
  :ends_at => Time.parse("2011-11-8 10:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','shugomaeda').id)

Talk.create(:title_en => "Inside Ruby: concurrency & garbage collection explained.", 
  :title_es => "Inside Ruby: concurrency & garbage collection explained.", 
  :starts_at => Time.parse("2011-11-8 10:30"),
  :ends_at => Time.parse("2011-11-8 11:10"),
  :speaker_id => Speaker.find_by_attribute('twitter','merbist').id)

Talk.create(:title_en => "The Timeless Way of Software Development", 
  :title_es => "La manera atemporal del desarrollo de software", 
  :starts_at => Time.parse("2011-11-8 11:40"),
  :ends_at => Time.parse("2011-11-8 12:10"),
  :speaker_id => Speaker.find_by_attribute('twitter','eto').id)


Talk.create(:title_en => "Throwing Ruby out the window", 
  :title_es => "Tirando Ruby por la ventana", 
  :starts_at => Time.parse("2011-11-8 12:40"),
  :ends_at => Time.parse("2011-11-8 13:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','luislavena').id)

Talk.create(:title_en => "The quiet and versatile Rubyist", 
  :title_es => "El rubyista silencioso y versátil", 
  :starts_at => Time.parse("2011-11-8 14:50"),
  :ends_at => Time.parse("2011-11-8 15:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','myabc').id)

Talk.create(:title_en => "What every programmer should know about distributed systems - lessons learned at Heroku", 
  :title_es => "Lo que todo programador debe saber sobre sistemas distribuidos - Lecciones aprendidas en Heroku", 
  :starts_at => Time.parse("2011-11-8 15:50"),
  :ends_at => Time.parse("2011-11-8 16:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','ped').id)  

Talk.create(:title_en => "How to become a data scientist with Ruby", 
  :title_es => "Como convertirse en un data scientist con Ruby", 
  :starts_at => Time.parse("2011-11-8 16:50"),
  :ends_at => Time.parse("2011-11-8 17:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','fbru02').id)


Talk.create(:title_en => "Monitoring with Syslog and EventMachine", 
  :title_es => "Monitoreo con Syslog y EventMachine", 
  :starts_at => Time.parse("2011-11-8 17:50"),
  :ends_at => Time.parse("2011-11-8 18:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','phuesler').id)

Talk.create(:title_en => "A Tale of Three Trees", 
  :title_es => "Un Cuento de Tres Árboles", 
  :starts_at => Time.parse("2011-11-8 18:50"),
  :ends_at => Time.parse("2011-11-8 20:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','chacon').id)

# Day 2
Talk.create(:title_en => "Who makes the best asado?", 
  :title_es => "Who makes the best asado?", 
  :starts_at => Time.parse("2011-11-9 9:00"),
  :ends_at => Time.parse("2011-11-9 9:40"),
  :speaker_id => Speaker.find_by_attribute('twitter','tenderlove').id)

Talk.create(:title_en => "Beyond Ruby", 
  :title_es => "Más allá de Ruby", 
  :starts_at => Time.parse("2011-11-9 10:10"),
  :ends_at => Time.parse("2011-11-9 10:50"),
  :speaker_id => Speaker.find_by_attribute('twitter','konstantinhaase').id)


Talk.create(:title_en => "Goat: A real-time web framework", 
  :title_es => "Goat: Un framework en tiempo real", 
  :starts_at => Time.parse("2011-11-9 11:20"),
  :ends_at => Time.parse("2011-11-9 11:50"),
  :speaker_id => Speaker.find_by_attribute('twitter','patrickc').id)


Talk.create(:title_en => '"Back to the future" with SQL and stored procedures', 
  :title_es => '"Volver al Futuro" con SQL y stored procedures', 
  :starts_at => Time.parse("2011-11-9 12:20"),
  :ends_at => Time.parse("2011-11-9 13:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','compay').id)



Talk.create(:title_en => "Lighting Talks", 
  :title_es => "Lighting Talks", 
  :starts_at => Time.parse("2011-11-9 14:30"),
  :ends_at => Time.parse("2011-11-9 15:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','RubyConfAr').id)

Talk.create(:title_en => "Testing: It's a horrible idea!", 
  :title_es => "Testing: Es una pésima idea!", 
  :starts_at => Time.parse("2011-11-9 15:30"),
  :ends_at => Time.parse("2011-11-9 16:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','godfoca').id)

Talk.create(:title_en => "Embrace NoSQL and Eventual Consistency with Ripple", 
  :title_es => "Adoptando NoSQL y consistencia eventual con Ripple", 
  :starts_at => Time.parse("2011-11-9 16:30"),
  :ends_at => Time.parse("2011-11-9 17:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','seancribbs').id)


Talk.create(:title_en => "Parallel worlds of CRuby's GC", 
  :title_es => "Los mundos paralelos del GC de CRuby", 
  :starts_at => Time.parse("2011-11-9 17:30"),
  :ends_at => Time.parse("2011-11-9 18:10"),
  :speaker_id => Speaker.find_by_attribute('twitter','nari_en').id)

Talk.create(:title_en => "Optimizing for happiness", 
  :title_es => "Optimizando para la felicidad", 
  :starts_at => Time.parse("2011-11-9 18:40"),
  :ends_at => Time.parse("2011-11-9 19:20"),
  :speaker_id => Speaker.find_by_attribute('twitter','mojombo').id)

Talk.create(:title_en => "RubyConf Argentina 2011 Closure", 
  :title_es => "Cierre de RubyConf Argentina 2011", 
  :starts_at => Time.parse("2011-11-9 19:20"),
  :ends_at => Time.parse("2011-11-9 20:00"),
  :speaker_id => Speaker.find_by_attribute('twitter','RubyConfAr').id)

