/* eslint no-console:0 */

// Rails Unobtrusive JavaScript (UJS) is *required* for links in Lucky that use DELETE, POST and PUT.
// Though it says "Rails" it actually works with any framework.
require('@rails/ujs').start();

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
require('turbolinks').start();

// If using Turbolinks, you can attach events to page load like this:
//
// document.addEventListener("turbolinks:load", function() {
//   ...
// })

var _paq = (window._paq = window._paq || []);
/* tracker methods like "setCustomDimension" should be called before "trackPageView" */
_paq.push(['setDocumentTitle', document.domain + '/' + document.title]);
_paq.push(['setCookieDomain', '*.vincent.jousse.org']);
_paq.push(['setDomains', ['*.vincent.jousse.org']]);
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
(function() {
  var u = '//stats.jousse.org/';
  _paq.push(['setTrackerUrl', u + 'matomo.php']);
  _paq.push(['setSiteId', '1']);
  var d = document,
    g = d.createElement('script'),
    s = d.getElementsByTagName('script')[0];
  g.type = 'text/javascript';
  g.async = true;
  g.src = u + 'matomo.js';
  s.parentNode.insertBefore(g, s);
})();
