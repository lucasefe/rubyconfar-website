require 'yaml_record'

class Speaker < YamlRecord::Base
  properties :name, :picture, :company, :twitter,
    :description_en, :description_es, :links, :talk

  source File.join(File.dirname(__FILE__), "../db/speakers")

end
