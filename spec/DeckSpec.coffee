assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  app = null
  dealer = null

  beforeEach ->

    app = new App()
    hand = app.get('playerHand')
    dealer = app.get('dealerHand')
    deck = app.get('deck')

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      lastCard = deck.last()
      hand.hit()
      assert.strictEqual(lastCard, hand.last())
      assert.strictEqual deck.length, 47

  describe 'stand', ->
    it 'should cause the dealer to play', ->
      lastScore = dealer.score()
      hand.stand()
      assert.notEqual(lastScore, dealer.score())

  describe 'bust', ->
    it 'should detect a bust event', ->
