class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    #@$el.addClass 'covered' unless @model.get 'revealed'
    @$('img').attr('src', "img/card-back.png") unless @model.get 'revealed'
