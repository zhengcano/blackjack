class window.AppView extends Backbone.View
  template: _.template '
    <div class="winLose"></div>
    <div class="dealer-hand-container hand-container"></div>
    <div class="player-hand-container hand-container"></div>
    <div class="buttons">
      <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    </div>
  '

  events:
    'click .hit-button':  'hit'
    'click .stand-button':  'stand'

  initialize: ->
    game = @model.get('game')
    game.on 'playerWin', =>
      @$('.winLose').text("You win!")
      @resetGame()

    game.on 'dealerWin', =>
      @$('button').hide()
      @$('.winLose').text("You lose!")
      @resetGame()

    game.on 'push', =>
      @$('.winLose').text("Tie!")
      @resetGame()

    game.get('playerHand').on 'stand', =>
      @$('button').hide()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el

  hit: ->
    @model.get('game').get('playerHand').hit()

  stand: ->
    @model.get('game').get('playerHand').stand()

  resetGame: ->
    view = @
    game = view.model.get('game')
    setTimeout (->
      game.shuffleDeck()
      game.reDeal()
      view.render()
    ), 3000
