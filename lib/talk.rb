require 'yaml_record'

class Talk < YamlRecord::Base
  properties :title_es, :title_en, 
    :starts_at, :ends_at, :speaker_id

  source File.join(File.dirname(__FILE__), "../db/talks")

  def speaker
    @speaker ||= Speaker.find(@speaker_id)
  end
end