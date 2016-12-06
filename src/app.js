'use strict';

(function(document) {
  var Elm = require('./Main.elm');
  var container = document.getElementById('app-container');

  var app = Elm.Main.embed(container);
})(document);
