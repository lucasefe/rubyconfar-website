require 'yaml_record'

class Talk < YamlRecord::Base
  properties :title_es, :title_en, 
    :starts_at, :ends_at, :speaker_id

  source File.join(File.dirname(__FILE__), "../db/talks")

  def speaker
    @speaker ||= Speaker.find(self.speaker_id)
  end

  def in_progress?(now = self.class.right_now)
    self.starts_at <= now && self.ends_at > now
  end

  class << self
    def all_talks
      self.all.sort_by(&:starts_at)
    end

    def find_current_and_upcoming
      talks = all_talks
      now = talks.find(&:in_progress?)
      upcoming_time = now ? now.ends_at : right_now
      upcoming = talks.find { |n| n.starts_at > upcoming_time }
      return now, upcoming
    end

    def right_now
      Time.now
    end
  end
end
