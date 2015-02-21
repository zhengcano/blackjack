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
      @model.reShuffle()
      @render()
      return
    @model.on 'dealerWin', =>
      alert 'You lose!'
      @model.reShuffle()
      @render()
      return
    @model.on 'push', =>
      alert 'Tie'
      @model.reShuffle()
      @render()
      return

    @render()

  render: ->
    console.log("here")
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  hit: ->
    @model.get('playerHand').hit()

  stand: ->
    @model.get('playerHand').stand()
