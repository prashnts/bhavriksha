# Bhav Vriksha

d3 = require 'd3'

App =
  init: ->
    console.log d3
    console.log "init success"
    @test()

  test: ->
    margin =
      top: 40
      right: 40
      bottom: 40
      left: 80
    width = 960 - (margin.left) - (margin.right)
    height = 500 - (margin.top) - (margin.bottom)
    tree = d3.layout.tree().size([
      width
      height
    ])
    diagonal = d3.svg.diagonal().projection((d) ->
      [
        d.x
        d.y
      ]
    )
    svg = d3.select('body')
      .append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
          .append('g')
            .attr('transform', "translate(#{margin.left}, #{margin.top})")

    d3.json 'flare.json', (error, root) ->
      if error
        throw error
      nodes = tree.nodes(root)
      links = tree.links(nodes)
      # Create the link lines.
      svg.selectAll('.link').data(links).enter().append('path').attr('class', 'link').attr 'd', diagonal
      # Create the node circles.
      node = svg.selectAll('.node').data(nodes).enter().append('g').attr('class', (d) ->
        'node ' + d.type
      ).attr('transform', (d) ->
        "translate(#{d.x}, #{d.y})"
      )
      node.append('circle').attr 'r', 4.5
      node.append('text').attr('x', -6).attr('dy', '.35em').attr('text-anchor', 'end').text (d) ->
        d.name

module.exports = App
