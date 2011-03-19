class AdminController < ApplicationController
  def index
    @message = "nil"
    @ht = "nil"
    @at = "nil"
    @d = "nil"
     begin
        @menter = Match.find(:first, :conditions => "played = 't' AND rated = 'f'")
        @ht = @menter.home_team
        @at = @menter.away_team
        @d = @menter.date_match
        @message = "There are match/matches to rate"
     rescue Exception => exc
        logger.error("Message for the log file #{exc.message}")
        @message = "No matches to rate"
     end
     if @message == "No matches to rate"
      begin
        @menter = Match.find(:first, :conditions => "played = 'f' AND rated = 'f'")
        @ht = @menter.home_team
        @at = @menter.away_team
        @d = @menter.date_match
        @message = "No scores entered for the next match."
     rescue Exception => exc
        logger.error("Message for the log file #{exc.message}")
        @message = "No more matches for which to enter results"
      end
     end
  end

  def enter_tournament
    
  end

  def tournament_save

  end

  def enter_match
    Match.create(:home_team => params[:home_team], :away_team => params[:away_team], :date_match => params[:date], :played => 'f', :rated => 'f')
  end

  def match_save

  end

  def enter_score
    @pres = Array.[]('Home', 'Away', 'Draw')
    @match = Match.find(:first, :conditions => "played = 'f' AND rated = 'f'")
    @tournament = Tournament.find(@match.tournament_id)
  end

  def score_save
    @match = Match.find(:first, :conditions => "played = 'f' AND rated = 'f'")
    Match.update(@match , :played => 't', :hpts => params[:hpts], :apts => params[:apts], :result => params[:result])
    @match.save
    redirect_to( :action => "index")
  end

  def rate_match
    begin
      @match = Match.find(:first, :conditions => "played = 't' AND rated = 'f'")
      @tournament = Tournament.find(@match.tournament_id)
      @hteam = Country.find_by_name (@match.home_team)
      @ateam = Country.find_by_name (@match.away_team)
      @hrc = @hteam.rating_current
      @arc = @ateam.rating_current
      @change = rating_calc(@hrc,@arc,@match.result,@match.hpts - @match.apts)
      @nhr = @hrc + @change if @match.result == "Home"
      @nhr = @hrc - @change if @match.result == "Away"
      @nar = @arc - @change if @match.result == "Home"
      @nar = @arc + @change if @match.result == "Away"

      @nhr = @hrc - @change if @match.result == "Draw"
    rescue Exception => exc
      logger.error("Message for the log file #{exc.message}")
      flash[:notice] = "No more matches to rate"
      redirect_to(:action => 'index')
    end
  end

  def rate_save
    @match = Match.find(:first, :conditions => "played = 't' AND rated = 'f'")
    Match.update(@match , :rated => 't')
    @match.save
    @hteam = Country.find_by_name (@match.home_team)
    Rating.create(:country_id => @hteam.id, :rate => @hteam.rating_current, :date => @match.date_match)
    Country.update(@hteam, :rating_current => params[:nhr], :date_current => params[:date])
    @hteam.save
    @ateam = Country.find_by_name (@match.away_team)
    Rating.create(:country_id => @ateam.id, :rate => @ateam.rating_current, :date => @match.date_match)
    Country.update(@ateam, :rating_current => params[:nar], :date_current => params[:date])
    @ateam.save
    redirect_to( :action => "index")
  end

  def rating_calc(hrate, arate, res, marg)
    hrate = hrate + 3
    diff = hrate - arate
    diffcalc = (10 + diff)/10 if res == "Away"
    diffcalc = (10 - diff)/10 if res == "Home"
    diffcalc = diff/10 if res == "Draw"
    diffcalc = 0 if diff > 10
    diffcalc = 2  if diff < -10
    diffcalc = diffcalc * 1.5 if marg > 15
    diffcalc = diffcalc * 1.5 if marg < -15
    return diffcalc
  end

end
