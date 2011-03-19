class DisplayController < ApplicationController
  def index
  end

  def table6nat11
    @m = Match.find_sixn_2011
    @teams = Array.[]('England', 'France', 'Ireland', 'Italy', 'Scotland', 'Wales')
    @played = Array.[](0, 0, 0, 0, 0, 0)
    @wins = Array.[](0, 0, 0, 0, 0, 0)
    @draw = Array.[](0, 0, 0, 0, 0, 0)
    @loss = Array.[](0, 0, 0, 0, 0, 0)
    @champ = Array.[](0, 0, 0, 0, 0, 0)
    @pfor = Array.[](0, 0, 0, 0, 0, 0)
    @pagin = Array.[](0, 0, 0, 0, 0, 0)

    @m.each do |mm|
      @res = mm.result
      @hpts = mm.hpts
      @apts = mm.apts
      @ht = mm.home_team
      @at = mm.away_team
      @winner = mm.home_team if @res == "Home"
      @winner = mm.away_team if @res == "Away"
      @loser = mm.away_team if @res == "Home"
      @loser = mm.home_team if @res == "Away"
      for i in 0..5
        @played[i] = @played[i] + 1 if @ht == @teams[i]
        @played[i] = @played[i] + 1 if @at == @teams[i]
        @wins[i] = @wins[i] + 1 if @winner == @teams[i]
        @champ[i] = @champ[i] + 2 if @winner == @teams[i]
        @draw[i] = @draw[i] + 1 if @res == "Draw"
        @champ[i] = @champ[i] + 1 if @res == "Draw"
        @loss[i] = @loss[i] + 1 if @loser == @teams[i]
        @pfor[i] = @pfor[i] + @hpts if mm.home_team == @teams[i]
        @pfor[i] = @pfor[i] + @apts if mm.away_team == @teams[i]
        @pagin[i] = @pagin[i] + @hpts if mm.away_team == @teams[i]
        @pagin[i] = @pagin[i] + @apts if mm.home_team == @teams[i]
      end
    end
    @sixnat = mda(6,9)
    for i in 0..5
      @sixnat[i][0] = @champ[i]
      @sixnat[i][1] = @pfor[i] - @pagin[i]
      @sixnat[i][2] = @played[i]
      @sixnat[i][3] = @wins[i]
      @sixnat[i][4] = @loss[i]
      @sixnat[i][5] = @draw[i]
      @sixnat[i][6] = @pfor[i]
      @sixnat[i][7] = @pagin[i]
      @sixnat[i][8] = @teams[i]
    end
    @sixnat = @sixnat.sort {|x,y|y<=>x}
  end

  def current_rating
    @c = Country.find(:all, :order => 'rating_current desc')
    # @c = Country.includes:all.order("rating_current")

  end

  def mda(width,height)
    a = Array.new(width)
    a.map! { Array.new(height) }
    return a
  end

end
