React = require 'react/addons'
TimeAgo = require './time-ago'
moment = require 'moment'
cx = React.addons.classSet

GameNum = React.createClass
  render: ->
    current = true if @props.gameNum is @props.currentGame
    classes = cx(
      'no-pad-xs': true
      'text-center': true
      'col-xs-4': true
      'current': current)

    <div className={classes}>
      <h5>{this.props.gameNum}</h5>
    </div>

GameScoreBox = React.createClass
  render: ->

    <div className="col-xs-4 text-center no-pad-xs">
      <TeamGameScore score={@props.scores.team1} otherScore={@props.scores.team2} isCurrentGame={@props.isCurrentGame}/>
      <TeamGameScore score={@props.scores.team2} otherScore={@props.scores.team1} isCurrentGame={@props.isCurrentGame}/>
    </div>

TeamGameScore = React.createClass
  render: ->
    won = @props.score > @props.otherScore && !@props.isCurrentGame
    lost = @props.score < @props.otherScore && !@props.isCurrentGame
    classes = cx(
      'winning-score': won
      'losing-score': lost)

    <h2 className={classes}>{@props.score}</h2>


module.exports = React.createClass

  render: ->
    gameNums = []
    gameScores = []
    match = this.props.match
    gameStart = undefined

    i = 1
    while i <= 3
      gameNums.push(<GameNum gameNum={i} currentGame={match.gameNum}/>)
      if match.scores.length >= i
        isCurrentGame = match.gameNum == i
        gameScores.push(<GameScoreBox scores={match.scores[i-1]} isCurrentGame={isCurrentGame}/>)
      else
        fakeScore =
          team1: 0
          team2: 0
        gameScores.push(<GameScoreBox scores={fakeScore} />)
      i++

    if match.gameNum > 1
      gameStart =
        <div className="row text-center">
          <h5><i className="fa fa-clock-o"></i><em>&nbsp;Game {match.gameNum} started <TimeAgo time={match.gameStartTime}/>.</em></h5>
        </div>

    <div className="row">
      <div className="col-md-12">
        <div className="jumbotron scoreboard text-center">
          <h1>Current Match</h1>
          <div className="row">
            <div className="col-sm-10 col-sm-offset-1">
              <div className="col-xs-6"></div>
              <div className="col-xs-6">
                <div className="row">
                  {gameNums}
                </div>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-10 col-sm-offset-1">
              <div className="col-xs-6">
                <div className="row">
                  <h2>{match.team1.title}</h2>
                </div>
                <div className="row">
                  <h2>{match.team2.title}</h2>
                </div>
              </div>
              <div className="col-xs-6 no-pad">
                {gameScores}
              </div>
            </div>
          </div>
          <div className="row text-center">
            <h3>Game {match.gameNum} In Progress</h3>
          </div>
          <div className="row text-center">
            <h5><i className="fa fa-clock-o"></i><em>&nbsp;Match started <TimeAgo time={match.startTime} />.</em></h5>
          </div>
          {gameStart}
        </div>
      </div>
    </div>


              # <div className="col-xs-6 team1-scores">
              #   <div repeat.for="score of currentMatch.scores" className="col-xs-4 no-pad-xs text-center score ${score.team1 &gt; score.team2 ? &quot;winning-score&quot; : &quot;&quot;}         ${score.team2 &gt; score.team1 ? &quot;losing-score&quot; : &quot;&quot;}">
              #     <h2>${score.team1}</h2>
              #   </div>
              #   <div if.bind="currentMatch.scores.length &lt; 3" className="col-xs-4 no-pad-xs text-center">
              #     <h2>0</h2>
              #   </div>
              #   <div if.bind="currentMatch.scores.length &lt; 2" className="col-xs-4 no-pad-xs text-center">
              #     <h2>0</h2>
              #   </div>
              # </div>


#         <div className="row">
#           <div className="col-sm-10 col-sm-offset-1">
#             <div className="col-xs-5 col-xs-offset-1 team2">
#               <h2>${team2Title}</h2>
#             </div>
#             <div flash.bind="currentTeam2" className="col-xs-6 team2-scores">
#               <div repeat.for="score of currentMatch.scores" className="col-xs-4 no-pad-xs text-center score ${score.team2 &gt; score.team1 ? &quot;winning-score&quot; : &quot;&quot;}         ${score.team1 &gt; score.team2 ? &quot;losing-score&quot; : &quot;&quot;}">
#                 <h2>${score.team2}</h2>
#               </div>
#               <div if.bind="currentMatch.scores.length &lt; 3" className="col-xs-4 no-pad-xs text-center">
#                 <h2>0</h2>
#               </div>
#               <div if.bind="currentMatch.scores.length &lt; 2" className="col-xs-4 no-pad-xs text-center">
#                 <h2>0</h2>
#               </div>
#             </div>
#           </div>
#         </div>
#         <div show.bind="startedMatch() &amp;&amp; currentMatch.gameNum !== 2" className="row tall stepper margin-top-1em heads-stepper">
#           <div className="col-xs-4 minus no-pad">
#             <button click.trigger="changeScore('team1','minus')" disabled.bind="currentTeam1 === 0 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-minus"></i></button>
#           </div>
#           <div className="col-xs-4">
#             <h3>${team1Title}</h3>
#           </div>
#           <div className="col-xs-4 plus no-pad">
#             <button click.trigger="changeScore('team1','plus')" disabled.bind="currentTeam1 === 10 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-plus"></i></button>
#           </div>
#         </div>
#         <div show.bind="startedMatch() &amp;&amp; currentMatch.gameNum !== 2" className="row tall stepper tails-stepper">
#           <div className="col-xs-4 minus no-pad">
#             <button click.trigger="changeScore('team2','minus')" disabled.bind="currentTeam2 === 0 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-minus"></i></button>
#           </div>
#           <div className="col-xs-4">
#             <h3>${team2Title}</h3>
#           </div>
#           <div className="col-xs-4 plus no-pad">
#             <button click.trigger="changeScore('team2','plus')" disabled.bind="currentTeam2 === 10 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-plus"></i></button>
#           </div>
#         </div>
#         <div show.bind="startedMatch() &amp;&amp; currentMatch.gameNum === 2" className="row tall stepper margin-top-1em tails-stepper">
#           <div className="col-xs-4 minus no-pad">
#             <button click.trigger="changeScore('team1','minus')" disabled.bind="currentTeam1 === 0 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-minus"></i></button>
#           </div>
#           <div className="col-xs-4">
#             <h3>${team1Title}</h3>
#           </div>
#           <div className="col-xs-4 plus no-pad">
#             <button click.trigger="changeScore('team1','plus')" disabled.bind="currentTeam1 === 10 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-plus"></i></button>
#           </div>
#         </div>
#         <div show.bind="startedMatch() &amp;&amp; currentMatch.gameNum === 2" className="row tall stepper heads-stepper">
#           <div className="col-xs-4 minus no-pad">
#             <button click.trigger="changeScore('team2','minus')" disabled.bind="currentTeam2 === 0 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-minus"></i></button>
#           </div>
#           <div className="col-xs-4">
#             <h3>${team2Title}</h3>
#           </div>
#           <div className="col-xs-4 plus no-pad">
#             <button click.trigger="changeScore('team2','plus')" disabled.bind="currentTeam2 === 10 || !currentMatch.active" className="btn btn-expand"><i className="fa fa-plus"></i></button>
#           </div>
#         </div>
#         <div show.bind="startedMatch()" className="row">
#           <div className="col-xs-12">
#             <button click.trigger="endMatch()" className="btn btn-danger btn-lg">End Match</button>
#           </div>
#         </div>
#         <div show.bind="!startedMatch()" className="row">
#           <h3>Game ${currentMatch.gameNum} In Progress</h3>
#         </div>
#         <div show.bind="!startedMatch()" className="row">
#           <div className="col-xs-12">
#             <h5><em>Game ${currentMatch.gameNum} started at ${moment(currentMatch.gameStartTime).format("h:mma")}</em></h5>
#             <h5><em>Match started at ${moment(currentMatch.startTime).format("h:mma")}</em></h5>
#           </div>
#         </div>