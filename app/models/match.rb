class Match < ActiveRecord::Base
  belongs_to :tournament

  def self.find_sixn_2011
    find(:all,:conditions => "played = 't' AND tournament_id = 1")
  end
end
