class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @createDecks(4)

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  createDecks: (n)->
    toAdd = []
    for [0...n]
      newDeck = _([0...52]).map (card) ->
        new Card
          rank: card % 13
          suit: Math.floor(card / 13)
      toAdd = toAdd.concat(newDeck)
    @add _.shuffle(toAdd)
