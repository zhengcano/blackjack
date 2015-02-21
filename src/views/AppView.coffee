class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="winLose"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button':  'hit'
    'click .stand-button':  'stand'

  initialize: ->
    @model.on 'playerWin', =>
      @$('.winLose').text("You win!")
      @resetGame()

    @model.on 'dealerWin', =>
      @$('.winLose').text("You lose!")
      @resetGame()

    @model.on 'push', =>
      @$('.winLose').text("Tie!");
      @resetGame()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

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
