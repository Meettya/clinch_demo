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
    dependencies = {"1456191539":{"./tmpl/hb_template":1291702702}};
    sources = {
"1291702702": function(exports, module, require) {
// /Users/meettya/github/clinch_demo/src/tmpl/hb_template.handlebars 
module.exports = function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"message\"><p>Hello ";
  if (stack1 = helpers.name) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.name; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  buffer += escapeExpression(stack1)
    + "!!!</p></div>";
  return buffer;
  }},
"1456191539": function(exports, module, require) {
// /Users/meettya/github/clinch_demo/src/hb_greater.coffee 
/*
This is simple test case for Handlebars-powered template engine
must work in browser only
*/

/*
This function render results with Handlebars template and given data
*/

var greater;

greater = function(data) {
  var res, template, template_fn;
  template_fn = require('./tmpl/hb_template');
  template = Handlebars.template(template_fn);
  return res = template(data);
};

module.exports = {
  greater: greater
};
}};

/* bundle export */
this.clinch_demo = {
"main": require(1456191539)};
}).call(this);