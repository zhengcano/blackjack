class window.AppView extends Backbone.View

  initialize: ->
    @gameView = new GameView(model: @model.get('game'))
    @render()

  render: ->
    @$el.html([@gameView.render()])
