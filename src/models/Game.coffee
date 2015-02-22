# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'maxCards', deck.length
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'hit', =>
      if @checkStrategy() is 'stand' then @trigger 'wrong', @
      else @trigger 'right', @

    @get('playerHand').on 'stand', =>

      dealer = @get('dealerHand')
      player = @get('playerHand')

      if @checkStrategy() is 'hit' then @trigger 'wrong', @
      else @trigger 'right', @

      # on stand, flip dealer's first card
      dealer.first().flip()

      # continue dealing while score < 17
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

  reDeal: ->
    deck = @get 'deck'
    dealer = @get('dealerHand')
    player = @get('playerHand')

    # If we create a new player/dealer, views won't work
    # Instead, we empty their hands and deal
    player.reset().add([deck.pop(), deck.pop()])
    dealer.reset().add([deck.pop().flip(), deck.pop()])

  shuffleDeck: ->
    deck = @get 'deck'
    if deck.length < @get('maxCards') * 0.25
      deck.reset()
      deck.createDecks(4)

  checkStrategy: ->
    dealer = @get('dealerHand')
    player = @get('playerHand')

    if player.score() < 12 then bestMove = 'hit'
    else if player.score() is 12 and (dealer.score() is 2 or dealer.score() is 3) then bestMove = 'hit'
    else if player.score() < 17 and (dealer.score() > 6 or dealer.score is 1) then bestMove = 'hit'
    else bestMove = 'stand'
    return bestMove
