!function(){"use strict";var t="undefined"==typeof window?global:window;if("function"!=typeof t.require){var e={},r={},n={},o={}.hasOwnProperty,u=/^\.\.?(\/|$)/,a=function(t,e){for(var r,n=[],o=(u.test(e)?t+"/"+e:e).split("/"),a=0,i=o.length;a<i;a++)r=o[a],".."===r?n.pop():"."!==r&&""!==r&&n.push(r);return n.join("/")},i=function(t){return t.split("/").slice(0,-1).join("/")},s=function(e){return function(r){var n=a(i(e),r);return t.require(n,e)}},l=function(t,e){var n={id:t,exports:{}};return r[t]=n,e(n.exports,s(t),n),n.exports},f=function(t){return n[t]?f(n[t]):t},c=function(t,n){null==n&&(n="/");var u=f(t);if(o.call(r,u))return r[u].exports;if(o.call(e,u))return l(u,e[u]);throw new Error("Cannot find module '"+t+"' from '"+n+"'")};c.alias=function(t,e){n[e]=t},c.reset=function(){e={},r={},n={}};var p=/\.[^.\/]+$/,d=/\/index(\.[^\/]+)?$/,h=function(t){if(p.test(t)){var e=t.replace(p,"");o.call(n,e)&&n[e].replace(p,"")!==e+"/index"||(n[e]=t)}if(d.test(t)){var r=t.replace(d,"");o.call(n,r)||(n[r]=t)}};c.register=c.define=function(t,n){if("object"==typeof t)for(var u in t)o.call(t,u)&&c.register(u,t[u]);else e[t]=n,delete r[t],h(t)},c.list=function(){var t=[];for(var r in e)o.call(e,r)&&t.push(r);return t},c.brunch=!0,c._cache=r,t.require=c}}(),require.register("app",function(t,e,r){var n,o,u;u=e("d3"),n=e("jquery"),o={test_data:'[[[[[{"token": "\\u0935\\u094d\\u092f\\u0915\\u094d\\u0924\\u093f", "pos": "NN"}, {"token": "\\u0936\\u0949\\u092a\\u093f\\u0902\\u0917", "pos": "XC"}], {"token": "\\u0914\\u0930", "pos": "CC:\\u0914\\u0930"}], [[{"token": "\\u090f\\u092f\\u0930\\u092a\\u094b\\u0930\\u094d\\u091f", "pos": "NN"}], [{"token": "\\u0938\\u0947", "pos": "PSP:\\u0938\\u0947"}, {"token": "\\u092d\\u0940", "pos": "RP"}]]], {"token": "\\u0921\\u0930\\u0924\\u093e", "pos": "VM"}], {"token": "\\u0939\\u0948", "pos": "VAUX"}]',init:function(){return this.test()},get_tree:function(t){var e,r;return r=function(t){var n;return Array.isArray(t)?2===t.length?{children:function(){var e,o,u;for(u=[],e=0,o=t.length;e<o;e++)n=t[e],u.push(r(n));return u}(),name:e(t)}:r(t[0]):{name:t.token}},e=function(t){var r;return Array.isArray(t)?function(){var n,o,u;for(u=[],n=0,o=t.length;n<o;n++)r=t[n],u.push(e(r));return u}().join(" "):t.token},r(JSON.parse(t))},test:function(){var t,e,r,o,a,i,s,l,f,c,p,d,h,v;return a={top:40,right:40,bottom:40,left:80},v=960-a.left-a.right,e=400-a.top-a.bottom,d=u.layout.tree().size([v,e]),t=u.svg.diagonal().projection(function(t){return[t.x,t.y]}),c=u.select("#body").append("svg").attr("width",v+a.left+a.right).attr("height",e+a.top+a.bottom).append("g").attr("transform","translate("+a.left+", "+a.top+")"),f=this.get_tree(this.test_data),s=d.nodes(f),o=d.links(s),c.selectAll(".link").data(o).enter().append("path").attr("class","link").attr("d",t),i=c.selectAll(".node").data(s).enter().append("g").attr("class",function(t){return"node "+t.type}).attr("transform",function(t){return"translate("+t.x+", "+t.y+")"}),l=n("#body").offset(),p=l.top,r=l.left,n(".toolbar").on("mouseleave",function(t){return n(this).addClass("hidden")}),i.append("circle").attr("r",10).attr("fill","#FFF").on("mouseover",function(t){var e;return e=this,n(".toolbar ul li").off("click"),n(".toolbar").css("top",t.y+p).css("left",t.x+r).removeClass("hidden"),n(".toolbar .phrase").text(t.name),n(".toolbar ul li").on("click",function(r){var o;return o=n(this),t.sentiment=o.attr("role"),n(e).attr("fill",o.css("background-color")),h()})}),h=function(){return i.append("text").attr("y",4).attr("text-anchor","middle").attr("class","sentiment").text(function(t){return t.sentiment}),i.append("text").attr("y",25).attr("text-anchor","middle").text(function(t){if(!t.children)return t.name})},h(),window.nodes=s}},r.exports=o});