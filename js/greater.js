(function() {
 'use strict';
    
var dependencies, name_resolver, require, sources, _this = this;

name_resolver = function(parent, name) {
  if (dependencies[parent] == null) {
    throw Error("no dependencies list for parent |" + parent + "|");
  }
  if (dependencies[parent][name] == null) {
    throw Error("no one module resolved, name - |" + name + "|, parent - |" + parent + "|");
  }
  return dependencies[parent][name];
};
require = function(name, parent) {
  var exports, module, module_source, resolved_name, _ref;
  if (!(module_source = sources[name])) {
    resolved_name = name_resolver(parent, name);
    if (!(module_source = sources[resolved_name])) {
      throw Error("can`t find module source code: original_name - |" + name + "|, resolved_name - |" + resolved_name + "|");
    }
  }
  module_source.call(_this,exports = {}, module = {}, function(mod_name) {
    return require(mod_name, resolved_name != null ? resolved_name : name);
  });
  return (_ref = module.exports) != null ? _ref : exports;
};
    dependencies = {"4195501628":{"fs":538996121,"./tmpl/template":978638470,"jade":538996121}};
    sources = {
"538996121": function(exports, module, require) {
// /Users/meettya/github/clinch_demo/web_modules/noops.coffee 
/*
This is noops shim
*/

module.exports = function() {};
},
"978638470": function(exports, module, require) {
// /Users/meettya/github/clinch_demo/src/tmpl/template.jade 
module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
var buf = [];
var self = locals || {};
var interp;
var __indent = [];
buf.push('\n<div class="message">\n  <p>Hello ' + escape((interp = self.name) == null ? '' : interp) + '!!!</p>\n</div>');return buf.join("");
}},
"4195501628": function(exports, module, require) {
// /Users/meettya/github/clinch_demo/src/greater.coffee 
/*
This is simple test case for Jade-powered template engine
must work in node AND in browser
may be used as example
*/

/*
this two must be reqiured for node
if you prefer have all require() in file head (an I think it good habit)
- you need to REPLACE it in clinch settings, not exclude!!!
*/

var fs, greater, jade;

fs = require('fs');

jade = require('jade');

/*
This function render results with jade template and given data
Its dual-headed version, works in node and in browser
*/


greater = function(data) {
  var options, res, template, template_fn, template_name;
  template_fn = module.id ? (template_name = "" + __dirname + "/tmpl/template.jade", template = fs.readFileSync(template_name, 'utf8'), options = {
    pretty: true,
    self: true,
    filename: template_name
  }, jade.compile(template, options)) : require('./tmpl/template');
  return res = template_fn(data);
};

module.exports = {
  greater: greater
};
}};

/* bundle export */
this.clinch_demo = {
"main": require(4195501628)};
}).call(this);