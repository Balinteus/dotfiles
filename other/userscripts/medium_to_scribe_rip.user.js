// ==UserScript==
// @name        Open Medium articles in scribe.rip
// @namespace   https://balint.gonda.dev/
// @include     https://*.medium.com/*
// @version     1
// @run-at      document-start
// ==/UserScript==

var mediumUsername = document.URL.split("https://")[1].split('.')[0];

var mediumPost = document.URL.split("https://")[1].split('/')[1];

window.location.replace(`https://scribe.rip/@${mediumUsername}/${mediumPost}`);
