# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'stand', =>

      dealer = @get('dealerHand')
      player = @get('playerHand')

      while dealer.score() < 17
        dealer.hit()
      if dealer.score() <= 21
        if player.score() > dealer.score()
          @trigger 'playerWin', @
        else if player.score() is dealer.score()
          @trigger 'push', @
        else
          @trigger 'dealerWin', @

    @get('playerHand').on 'lose', =>
      @trigger 'dealerWin', @

    @get('dealerHand').on 'lose', =>
      @trigger 'playerWin', @


