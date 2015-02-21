class window.GameView extends Backbone.View
  template: _.template '
    <h1>Blackbeard Jack</h1>
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

  className: 'gameview'

  initialize: ->
    @model.on 'playerWin', =>
      @$('.winLose').text("You win!")
      @resetGame()

    @model.on 'dealerWin', =>
      @$('button').hide()
      @$('.winLose').text("You lose!")
      @resetGame()

    @model.on 'push', =>
      @$('.winLose').text("Tie!")
      @resetGame()

    @model.get('playerHand').on 'stand', =>
      @$('button').hide()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el

  hit: ->
    @model.get('playerHand').hit()

  stand: ->
    @model.get('playerHand').stand()

  resetGame: ->
    view = @
    setTimeout (->
      view.model.shuffleDeck()
      view.model.reDeal()
      view.render()
    ), 3000
