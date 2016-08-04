# Bhav Vriksha
d3 = require 'd3'
$ = require 'jquery'
pace = require 'pace-progress'
_compact = require 'lodash/compact'

App =
  init: ->
    pace.start()
    @init_canvas()
    @get_sentence()
    $('#new').on 'click', => @annotate_sentence()

  annotate_sentence: ->
    if @stahp is yes then return
    emotion = $('input[name="emotion"]:checked').attr('checked', no).val()
    $.ajax
      url: "/api/treebank/#{@oid}"
      method: 'POST'
      data: annotation: @flatten_tree(@root, emotion)
    .done =>
      @get_sentence()

  get_sentence: ->
    @stahp = yes
    $.ajax
      url: '/api/treebank'
    .done (data) =>
      @oid = data.id
      @root = @parse_tree data.parse_tree
      @draw_tree()
    .always =>
      @stahp = no

  parse_tree: (data) ->
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

  flatten_tree: (data, emotion) ->
    parse = (nodes) ->
      if nodes.children?
        nodes_s = (parse child for child in nodes.children)
      else
        nodes_s = nodes.name
      sentiment = do (d = nodes.sentiment) -> if d then "s:#{d}"
      [_compact [nodes_s, sentiment]]
    parsed_tree = parse(data)
    if emotion? then parsed_tree.push("e:#{emotion}")
    JSON.stringify parsed_tree

  init_canvas: ->
    margin =
      top: 40
      left: do (w = $('header').width()) ->
        if w is 350 then 350
        else 40
      bottom: 40
      right: 40

    width = $(window).width() - (margin.left) - (margin.right)
    height = $(window).height() - (margin.top) - (margin.bottom)

    @tree = d3.layout
      .tree().size [width, height]

    @diagonal = d3.svg
      .diagonal()
      .projection (d) -> [d.x, d.y]

    @svg = d3.select('#body')
      .append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
          .append('g')
            .attr('transform', "translate(#{margin.left}, #{margin.top})")

    $('.toolbar').on 'mouseleave touchend', (e) ->
      $(@).addClass 'hidden'

  draw_tree: ->
    @svg.selectAll('*').remove()

    nodes = @tree.nodes(@root)
    links = @tree.links(nodes)

    $('#sentence').text @root.name

    @svg.selectAll('.link')
      .data(links)
        .enter()
        .append('path')
          .attr('class', 'link')
          .attr('d', @diagonal)
    node = @svg.selectAll('.node')
      .data(nodes)
        .enter()
        .append('g')
          .attr('class', (d) -> "node #{d.type}")
          .attr('transform', (d) -> "translate(#{d.x}, #{d.y})")

    {top, left} = $('#body').offset()
    right = do (d = $('header').width()) -> if d is 350 then 260 else 0

    node
      .append 'circle'
        .attr 'r', 10
        .attr 'fill', '#FFF'
        .on 'mouseover', (d) ->
          self = @
          $('.toolbar ul li').off 'click'
          $('.toolbar')
            .css 'top', d.y + top
            .css 'left', d.x + left + right
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


module.exports = App
