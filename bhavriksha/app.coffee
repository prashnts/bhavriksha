# Bhav Vriksha

d3 = require 'd3'
$ = require 'jquery'

App =
  # coffeelint: disable=max_line_length
  test_data: "[[[[[{\"token\": \"\\u0935\\u094d\\u092f\\u0915\\u094d\\u0924\\u093f\", \"pos\": \"NN\"}, {\"token\": \"\\u0936\\u0949\\u092a\\u093f\\u0902\\u0917\", \"pos\": \"XC\"}], {\"token\": \"\\u0914\\u0930\", \"pos\": \"CC:\\u0914\\u0930\"}], [[{\"token\": \"\\u090f\\u092f\\u0930\\u092a\\u094b\\u0930\\u094d\\u091f\", \"pos\": \"NN\"}], [{\"token\": \"\\u0938\\u0947\", \"pos\": \"PSP:\\u0938\\u0947\"}, {\"token\": \"\\u092d\\u0940\", \"pos\": \"RP\"}]]], {\"token\": \"\\u0921\\u0930\\u0924\\u093e\", \"pos\": \"VM\"}], {\"token\": \"\\u0939\\u0948\", \"pos\": \"VAUX\"}]"
  # coffeelint: enable=max_line_length

  init: ->
    @test()

  get_tree: (data) ->
    parse = (nodes) ->
      if Array.isArray(nodes)
        if nodes.length is 2
          children: (parse(_) for _ in nodes)
          name: flat(nodes)
        else
          parse(nodes[0])
      else
        name: nodes.token

    flat = (nodes) ->
      if Array.isArray nodes
        return (flat(node) for node in nodes).join(' ')
      else
        return nodes.token
    parse JSON.parse(data)

  test: ->
    margin =
      top: 40
      right: 40
      bottom: 40
      left: 80
    width = 960 - (margin.left) - (margin.right)
    height = 400 - (margin.top) - (margin.bottom)
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
    svg = d3.select('#body')
      .append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
          .append('g')
            .attr('transform', "translate(#{margin.left}, #{margin.top})")

    root = @get_tree @test_data

    nodes = tree.nodes(root)
    links = tree.links(nodes)
    # Create the link lines.
    svg.selectAll('.link')
      .data(links)
        .enter()
        .append('path')
          .attr('class', 'link')
          .attr('d', diagonal)

    # Create the node circles.
    node = svg.selectAll('.node')
      .data(nodes)
        .enter()
        .append('g')
          .attr('class', (d) -> "node #{d.type}")
          .attr('transform', (d) -> "translate(#{d.x}, #{d.y})")

    {top, left} = $('#body').offset()

    $('.toolbar').on 'mouseleave', (e) ->
      $(@).addClass 'hidden'

    node
      .append 'circle'
        .attr 'r', 10
        .attr 'fill', '#FFF'
        .on 'mouseover', (d) ->
          self = @
          $('.toolbar ul li').off 'click'
          $('.toolbar')
            .css 'top', d.y + top
            .css 'left', d.x + left
            .removeClass 'hidden'
          $('.toolbar .phrase').text d.name

          $('.toolbar ul li').on 'click', (e) ->
            el = $(@)
            d.sentiment = el.attr('role')
            $(self).attr 'fill', el.css('background-color')
            update_labels()

    update_labels = ->
      node
        .selectAll 'text.sentiment'
        .text (d) -> d.sentiment

    node
      .append 'text'
        .attr 'y', 4
        .attr 'text-anchor', 'middle'
        .attr 'class', 'sentiment'
        .text (d) -> d.sentiment

    node
      .append 'text'
        .attr 'y', 25
        .attr 'text-anchor', 'middle'
        .text (d) ->
          unless d.children then d.name

    update_labels()
    window.nodes = nodes


module.exports = App
