class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button':  'hit'
    'click .stand-button':  'stand'

  initialize: ->
    @model.on 'playerWin', =>
      alert 'You win!'
      @model.shuffleDeck()
      @model.reDeal()
      @render()

    @model.on 'dealerWin', =>
      alert 'You lose!'
      @model.shuffleDeck()
      @model.reDeal()
      @render()

    @model.on 'push', =>
      alert 'Tie'
      @model.shuffleDeck()
      @model.reDeal()
      @render()

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
