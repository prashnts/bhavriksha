# Bhav Vriksha

module.exports = config:
  paths:
    watched: ['bhavriksha']

  plugins:
    autoReload:
      enabled: yes
    coffeelint:
      pattern: /^bhavriksha\/.*\.(coffee)$/
      useCoffeelintJson: yes
    jaded:
      staticPatterns: /^bhavriksha\/markup\/([\d\w]*)\.jade$/
    postcss:
      processors: [
        require('autoprefixer')(['last 8 versions'])
      ]
    stylus:
      plugins: [
        'jeet'
        'bootstrap-styl'
      ]

  npm:
    enabled: yes
    styles:
      'normalize.css': [
        'normalize.css'
      ]

  modules:
    nameCleaner: (path) ->
      path
        .replace /^bhavriksha\//, ''
        .replace /\.coffee/, ''

  files:
    javascripts:
      joinTo:
        'js/libraries.js': /^(?!bhavriksha\/)/
        'js/app.js': /^bhavriksha\//
    stylesheets:
      joinTo:
        'css/libraries.css': /^(?!bhavriksha\/)/
        'css/app.css': /^bhavriksha\//
