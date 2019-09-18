---
layout: post
title:  "Powerful things you can do with the Markdown editor"
author: sal
categories: [ Jekyll, tutorial ]
image: assets/images/16.jpg
---
<style>
thead{display:table-header-group;}
tr,img{page-break-inside:avoid;}
.ka.table-check::after{content:url("https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/green-check.svg");}
.ka.table-cross::after{content:url("https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/red-x.svg");}
.ka.left-quote::after{content:url("https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/left-quote.svg");}
.ka.availability::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/availability.svg);content:'';}
.ka.cloud-native::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/cloud-native.svg);content:'';}
.ka.complete::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/complete.svg);content:'';}
.ka.control::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/control.svg);content:'';}
.ka.edge-security::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/edge-security.svg);content:'';}
.ka.expertise-insight::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/expertise-insight.svg);content:'';}
.ka.flexible::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/flexbile.svg);content:'';}
.ka.flexible-consumption::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/flexible-consumption.svg);content:'';}
.ka.global-dns::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/global-dns.svg);content:'';}
.ka.layer-4-7::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/layer-4-7.svg);content:'';}
.ka.metered::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/metered.svg);content:'';}
.ka.resiliant::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/resiliant.svg);content:'';}
.ka.reverse-proxy::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/reverse-proxy.svg);content:'';}
.ka.sdn::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/sdn.svg);content:'';}
.ka.secure::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/secure.svg);content:'';}
.ka.simple::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/simple.svg);content:'';}
.ka.sub-licensing::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/sub-licensing.svg);content:'';}
.ka.visibility::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/visibility.svg);content:'';}
.ka.training::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/training.svg);content:'';}
.ka.waf::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/waf.svg);content:'';}
.ka.facebook::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/facebook.svg);content:'';}
.ka.github::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/github.svg);content:'';}
.ka.linkedin::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/linkedin.svg);content:'';}
.ka.twitter::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/twitter.svg);content:'';}
.ka.youtube::after{background:url(https://d3av4ai3v402jn.cloudfront.net/sites/all/themes/custom/kemp_bootstrap/images/youtube.svg);content:'';}
.ka.standardize{display:block;width:42px;height:42px;position:relative;}
.ka.standardize::after{background-size:contain;width:100%;height:100%;position:absolute;left:0;top:0;background-repeat:no-repeat;}
.table-narrow,.table-wide,.table-long-text{width:100%;border:1px solid #eaebec;margin-bottom:1em;}
.table-narrow thead,.table-wide thead,.table-long-text thead{background-color:#fff;border-bottom:1px solid #eaebec;}
.table-narrow thead th,.table-wide thead th,.table-long-text thead th{color:#333334;font-weight:600;font-size:.875em;}
.table-narrow tbody tr td,.table-wide tbody tr td,.table-long-text tbody tr td{color:#333334;font-weight:400;font-size:.75em;}
.table-narrow td:first-child,.table-narrow th:first-child{width:40%;}
.table-jambalaya{width:100%;margin-bottom:1em;border:1px solid #d8d8d8;background-color:#fff;box-shadow:0 5px 20px 0 #cbd6e2;font-size:.875em;}
.table-jambalaya tr:not(.divider):not(.text) td,.table-jambalaya tr:not(.divider):not(.text) th{text-align:center;padding:1.5em;}
.table-jambalaya tr:not(.divider):not(.text) th{font-size:1.429em;color:#3d70ce;font-weight:600;}
.table-jambalaya tr:not(.divider):not(.text) th .pricing{font-size:.8em;color:#333334;}
.table-jambalaya tr.divider td .div-cell h5{display:inline;font-size:1.29em;}
.table-jambalaya tr.text>td>.row .list-hold{padding-top:2em;padding-bottom:2em;}
.table{border-collapse:collapse!important;width:100%;max-width:100%;margin-bottom:20px;}
.table-bordered th,.table-bordered td{border:1px solid #ddd!important;}

.glyphicon{position:relative;top:1px;display:inline-block;font-family:'Glyphicons Halflings';font-style:normal;font-weight:400;line-height:1;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;}
.glyphicon-asterisk:before{content:"\002a";}
.glyphicon-plus:before{content:"\002b";}
.glyphicon-euro:before,.glyphicon-eur:before{content:"\20ac";}
.glyphicon-minus:before{content:"\2212";}
.glyphicon-cloud:before{content:"\2601";}
.glyphicon-envelope:before{content:"\2709";}
.glyphicon-pencil:before{content:"\270f";}
.glyphicon-glass:before{content:"\e001";}
.glyphicon-music:before{content:"\e002";}
.glyphicon-search:before{content:"\e003";}
.glyphicon-heart:before{content:"\e005";}
.glyphicon-star:before{content:"\e006";}
.glyphicon-star-empty:before{content:"\e007";}
.glyphicon-user:before{content:"\e008";}
.glyphicon-film:before{content:"\e009";}
.glyphicon-th-large:before{content:"\e010";}
.glyphicon-th:before{content:"\e011";}
.glyphicon-th-list:before{content:"\e012";}
.glyphicon-ok:before{content:"\e013";}
.glyphicon-remove:before{content:"\e014";}
.glyphicon-zoom-in:before{content:"\e015";}
.glyphicon-zoom-out:before{content:"\e016";}
.glyphicon-off:before{content:"\e017";}
.glyphicon-signal:before{content:"\e018";}
.glyphicon-cog:before{content:"\e019";}
.glyphicon-trash:before{content:"\e020";}
.glyphicon-home:before{content:"\e021";}
.glyphicon-file:before{content:"\e022";}
.glyphicon-time:before{content:"\e023";}
.glyphicon-road:before{content:"\e024";}
.glyphicon-download-alt:before{content:"\e025";}
.glyphicon-download:before{content:"\e026";}
.glyphicon-upload:before{content:"\e027";}
.glyphicon-inbox:before{content:"\e028";}
.glyphicon-play-circle:before{content:"\e029";}
.glyphicon-repeat:before{content:"\e030";}
.glyphicon-refresh:before{content:"\e031";}
.glyphicon-list-alt:before{content:"\e032";}
.glyphicon-lock:before{content:"\e033";}
.glyphicon-flag:before{content:"\e034";}
.glyphicon-headphones:before{content:"\e035";}
.glyphicon-volume-off:before{content:"\e036";}
.glyphicon-volume-down:before{content:"\e037";}
.glyphicon-volume-up:before{content:"\e038";}
.glyphicon-qrcode:before{content:"\e039";}
.glyphicon-barcode:before{content:"\e040";}
.glyphicon-tag:before{content:"\e041";}
.glyphicon-tags:before{content:"\e042";}
.glyphicon-book:before{content:"\e043";}
.glyphicon-bookmark:before{content:"\e044";}
.glyphicon-print:before{content:"\e045";}
.glyphicon-camera:before{content:"\e046";}
.glyphicon-font:before{content:"\e047";}
.glyphicon-bold:before{content:"\e048";}
.glyphicon-italic:before{content:"\e049";}
.glyphicon-text-height:before{content:"\e050";}
.glyphicon-text-width:before{content:"\e051";}
.glyphicon-align-left:before{content:"\e052";}
.glyphicon-align-center:before{content:"\e053";}
.glyphicon-align-right:before{content:"\e054";}
.glyphicon-align-justify:before{content:"\e055";}
.glyphicon-list:before{content:"\e056";}
.glyphicon-indent-left:before{content:"\e057";}
.glyphicon-indent-right:before{content:"\e058";}
.glyphicon-facetime-video:before{content:"\e059";}
.glyphicon-picture:before{content:"\e060";}
.glyphicon-map-marker:before{content:"\e062";}
.glyphicon-adjust:before{content:"\e063";}
.glyphicon-tint:before{content:"\e064";}
.glyphicon-edit:before{content:"\e065";}
.glyphicon-share:before{content:"\e066";}
.glyphicon-check:before{content:"\e067";}
.glyphicon-move:before{content:"\e068";}
.glyphicon-step-backward:before{content:"\e069";}
.glyphicon-fast-backward:before{content:"\e070";}
.glyphicon-backward:before{content:"\e071";}
.glyphicon-play:before{content:"\e072";}
.glyphicon-pause:before{content:"\e073";}
.glyphicon-stop:before{content:"\e074";}
.glyphicon-forward:before{content:"\e075";}
.glyphicon-fast-forward:before{content:"\e076";}
.glyphicon-step-forward:before{content:"\e077";}
.glyphicon-eject:before{content:"\e078";}
.glyphicon-chevron-left:before{content:"\e079";}
.glyphicon-chevron-right:before{content:"\e080";}
.glyphicon-plus-sign:before{content:"\e081";}
.glyphicon-minus-sign:before{content:"\e082";}
.glyphicon-remove-sign:before{content:"\e083";}
.glyphicon-ok-sign:before{content:"\e084";}
.glyphicon-question-sign:before{content:"\e085";}
.glyphicon-info-sign:before{content:"\e086";}
.glyphicon-screenshot:before{content:"\e087";}
.glyphicon-remove-circle:before{content:"\e088";}
.glyphicon-ok-circle:before{content:"\e089";}
.glyphicon-ban-circle:before{content:"\e090";}
.glyphicon-arrow-left:before{content:"\e091";}
.glyphicon-arrow-right:before{content:"\e092";}
.glyphicon-arrow-up:before{content:"\e093";}
.glyphicon-arrow-down:before{content:"\e094";}
.glyphicon-share-alt:before{content:"\e095";}
.glyphicon-resize-full:before{content:"\e096";}
.glyphicon-resize-small:before{content:"\e097";}
.glyphicon-exclamation-sign:before{content:"\e101";}
.glyphicon-gift:before{content:"\e102";}
.glyphicon-leaf:before{content:"\e103";}
.glyphicon-fire:before{content:"\e104";}
.glyphicon-eye-open:before{content:"\e105";}
.glyphicon-eye-close:before{content:"\e106";}
.glyphicon-warning-sign:before{content:"\e107";}
.glyphicon-plane:before{content:"\e108";}
.glyphicon-calendar:before{content:"\e109";}
.glyphicon-random:before{content:"\e110";}
.glyphicon-comment:before{content:"\e111";}
.glyphicon-magnet:before{content:"\e112";}
.glyphicon-chevron-up:before{content:"\e113";}
.glyphicon-chevron-down:before{content:"\e114";}
.glyphicon-retweet:before{content:"\e115";}
.glyphicon-shopping-cart:before{content:"\e116";}
.glyphicon-folder-close:before{content:"\e117";}
.glyphicon-folder-open:before{content:"\e118";}
.glyphicon-resize-vertical:before{content:"\e119";}
.glyphicon-resize-horizontal:before{content:"\e120";}
.glyphicon-hdd:before{content:"\e121";}
.glyphicon-bullhorn:before{content:"\e122";}
.glyphicon-bell:before{content:"\e123";}
.glyphicon-certificate:before{content:"\e124";}
.glyphicon-thumbs-up:before{content:"\e125";}
.glyphicon-thumbs-down:before{content:"\e126";}
.glyphicon-hand-right:before{content:"\e127";}
.glyphicon-hand-left:before{content:"\e128";}
.glyphicon-hand-up:before{content:"\e129";}
.glyphicon-hand-down:before{content:"\e130";}
.glyphicon-circle-arrow-right:before{content:"\e131";}
.glyphicon-circle-arrow-left:before{content:"\e132";}
.glyphicon-circle-arrow-up:before{content:"\e133";}
.glyphicon-circle-arrow-down:before{content:"\e134";}
.glyphicon-globe:before{content:"\e135";}
.glyphicon-wrench:before{content:"\e136";}
.glyphicon-tasks:before{content:"\e137";}
.glyphicon-filter:before{content:"\e138";}
.glyphicon-briefcase:before{content:"\e139";}
.glyphicon-fullscreen:before{content:"\e140";}
.glyphicon-dashboard:before{content:"\e141";}
.glyphicon-paperclip:before{content:"\e142";}
.glyphicon-heart-empty:before{content:"\e143";}
.glyphicon-link:before{content:"\e144";}
.glyphicon-phone:before{content:"\e145";}
.glyphicon-pushpin:before{content:"\e146";}
.glyphicon-usd:before{content:"\e148";}
.glyphicon-gbp:before{content:"\e149";}
.glyphicon-sort:before{content:"\e150";}
.glyphicon-sort-by-alphabet:before{content:"\e151";}
.glyphicon-sort-by-alphabet-alt:before{content:"\e152";}
.glyphicon-sort-by-order:before{content:"\e153";}
.glyphicon-sort-by-order-alt:before{content:"\e154";}
.glyphicon-sort-by-attributes:before{content:"\e155";}
.glyphicon-sort-by-attributes-alt:before{content:"\e156";}
.glyphicon-unchecked:before{content:"\e157";}
.glyphicon-expand:before{content:"\e158";}
.glyphicon-collapse-down:before{content:"\e159";}
.glyphicon-collapse-up:before{content:"\e160";}
.glyphicon-log-in:before{content:"\e161";}
.glyphicon-flash:before{content:"\e162";}
.glyphicon-log-out:before{content:"\e163";}
.glyphicon-new-window:before{content:"\e164";}
.glyphicon-record:before{content:"\e165";}
.glyphicon-save:before{content:"\e166";}
.glyphicon-open:before{content:"\e167";}
.glyphicon-saved:before{content:"\e168";}
.glyphicon-import:before{content:"\e169";}
.glyphicon-export:before{content:"\e170";}
.glyphicon-send:before{content:"\e171";}
.glyphicon-floppy-disk:before{content:"\e172";}
.glyphicon-floppy-saved:before{content:"\e173";}
.glyphicon-floppy-remove:before{content:"\e174";}
.glyphicon-floppy-save:before{content:"\e175";}
.glyphicon-floppy-open:before{content:"\e176";}
.glyphicon-credit-card:before{content:"\e177";}
.glyphicon-transfer:before{content:"\e178";}
.glyphicon-cutlery:before{content:"\e179";}
.glyphicon-header:before{content:"\e180";}
.glyphicon-compressed:before{content:"\e181";}
.glyphicon-earphone:before{content:"\e182";}
.glyphicon-phone-alt:before{content:"\e183";}
.glyphicon-tower:before{content:"\e184";}
.glyphicon-stats:before{content:"\e185";}
.glyphicon-sd-video:before{content:"\e186";}
.glyphicon-hd-video:before{content:"\e187";}
.glyphicon-subtitles:before{content:"\e188";}
.glyphicon-sound-stereo:before{content:"\e189";}
.glyphicon-sound-dolby:before{content:"\e190";}
.glyphicon-sound-5-1:before{content:"\e191";}
.glyphicon-sound-6-1:before{content:"\e192";}
.glyphicon-sound-7-1:before{content:"\e193";}
.glyphicon-copyright-mark:before{content:"\e194";}
.glyphicon-registration-mark:before{content:"\e195";}
.glyphicon-cloud-download:before{content:"\e197";}
.glyphicon-cloud-upload:before{content:"\e198";}
.glyphicon-tree-conifer:before{content:"\e199";}
.glyphicon-tree-deciduous:before{content:"\e200";}
.glyphicon-cd:before{content:"\e201";}
.glyphicon-save-file:before{content:"\e202";}
.glyphicon-open-file:before{content:"\e203";}
.glyphicon-level-up:before{content:"\e204";}
.glyphicon-copy:before{content:"\e205";}
.glyphicon-paste:before{content:"\e206";}
.glyphicon-alert:before{content:"\e209";}
.glyphicon-equalizer:before{content:"\e210";}
.glyphicon-king:before{content:"\e211";}
.glyphicon-queen:before{content:"\e212";}
.glyphicon-pawn:before{content:"\e213";}
.glyphicon-bishop:before{content:"\e214";}
.glyphicon-knight:before{content:"\e215";}
.glyphicon-baby-formula:before{content:"\e216";}
.glyphicon-tent:before{content:"\26fa";}
.glyphicon-blackboard:before{content:"\e218";}
.glyphicon-bed:before{content:"\e219";}
.glyphicon-apple:before{content:"\f8ff";}
.glyphicon-erase:before{content:"\e221";}
.glyphicon-hourglass:before{content:"\231b";}
.glyphicon-lamp:before{content:"\e223";}
.glyphicon-duplicate:before{content:"\e224";}
.glyphicon-piggy-bank:before{content:"\e225";}
.glyphicon-scissors:before{content:"\e226";}
.glyphicon-scale:before{content:"\e230";}
.glyphicon-ice-lolly:before{content:"\e231";}
.glyphicon-ice-lolly-tasted:before{content:"\e232";}
.glyphicon-education:before{content:"\e233";}
.glyphicon-option-horizontal:before{content:"\e234";}
.glyphicon-option-vertical:before{content:"\e235";}
.glyphicon-menu-hamburger:before{content:"\e236";}
.glyphicon-modal-window:before{content:"\e237";}
.glyphicon-oil:before{content:"\e238";}
.glyphicon-grain:before{content:"\e239";}
.glyphicon-sunglasses:before{content:"\e240";}
.glyphicon-text-size:before{content:"\e241";}
.glyphicon-text-color:before{content:"\e242";}
.glyphicon-text-background:before{content:"\e243";}
.glyphicon-object-align-top:before{content:"\e244";}
.glyphicon-object-align-bottom:before{content:"\e245";}
.glyphicon-object-align-horizontal:before{content:"\e246";}
.glyphicon-object-align-left:before{content:"\e247";}
.glyphicon-object-align-vertical:before{content:"\e248";}
.glyphicon-object-align-right:before{content:"\e249";}
.glyphicon-triangle-right:before{content:"\e250";}
.glyphicon-triangle-left:before{content:"\e251";}
.glyphicon-triangle-bottom:before{content:"\e252";}
.glyphicon-triangle-top:before{content:"\e253";}
.glyphicon-console:before{content:"\e254";}
.glyphicon-superscript:before{content:"\e255";}
.glyphicon-subscript:before{content:"\e256";}
.glyphicon-menu-left:before{content:"\e257";}
.glyphicon-menu-right:before{content:"\e258";}
.glyphicon-menu-down:before{content:"\e259";}
.glyphicon-menu-up:before{content:"\e260";}

.table>thead>tr>th{vertical-align:bottom;border-bottom:2px solid #ddd;}
.table>tbody+tbody{border-top:2px solid #ddd;}
.table-condensed>thead>tr>th,.table-condensed>thead>tr>td,.table-condensed>tbody>tr>th,.table-condensed>tbody>tr>td,.table-condensed>tfoot>tr>th,.table-condensed>tfoot>tr>td{padding:5px;}
.table-bordered>thead>tr>th,.table-bordered>thead>tr>td{border-bottom-width:2px;}
.table-striped>tbody>tr:nth-of-type(odd){background-color:#f9f9f9;}
table col[class*="col-"]{position:static;float:none;display:table-column;}
table td[class*="col-"],table th[class*="col-"]{position:static;float:none;display:table-cell;}
.table-hover>tbody>tr>td.active:hover,.table-hover>tbody>tr>th.active:hover,.table-hover>tbody>tr.active:hover>td,.table-hover>tbody>tr:hover>.active,.table-hover>tbody>tr.active:hover>th{background-color:#e8e8e8;}
.table-hover>tbody>tr>td.success:hover,.table-hover>tbody>tr>th.success:hover,.table-hover>tbody>tr.success:hover>td,.table-hover>tbody>tr:hover>.success,.table-hover>tbody>tr.success:hover>th{background-color:#d0e9c6;}
.table-hover>tbody>tr>td.info:hover,.table-hover>tbody>tr>th.info:hover,.table-hover>tbody>tr.info:hover>td,.table-hover>tbody>tr:hover>.info,.table-hover>tbody>tr.info:hover>th{background-color:#c4e3f3;}
.table-hover>tbody>tr>td.warning:hover,.table-hover>tbody>tr>th.warning:hover,.table-hover>tbody>tr.warning:hover>td,.table-hover>tbody>tr:hover>.warning,.table-hover>tbody>tr.warning:hover>th{background-color:#faf2cc;}
.table-hover>tbody>tr>td.danger:hover,.table-hover>tbody>tr>th.danger:hover,.table-hover>tbody>tr.danger:hover>td,.table-hover>tbody>tr:hover>.danger,.table-hover>tbody>tr.danger:hover>th{background-color:#ebcccc;}
.table-responsive{overflow-x:auto;min-height:.01%;}

.fa.fa-glass:before{content:"\f000";}
.fa.fa-star-o:before{content:"\f005";}
.fa.fa-close:before,.fa.fa-remove:before{content:"\f00d";}
.fa.fa-gear:before{content:"\f013";}
.fa.fa-file-o:before{content:"\f15b";}
.fa.fa-clock-o:before{content:"\f017";}
.fa.fa-arrow-circle-o-down:before{content:"\f358";}
.fa.fa-arrow-circle-o-up:before{content:"\f35b";}
.fa.fa-play-circle-o:before{content:"\f144";}
.fa.fa-repeat:before,.fa.fa-rotate-right:before{content:"\f01e";}
.fa.fa-refresh:before{content:"\f021";}
.fa.fa-dedent:before{content:"\f03b";}
.fa.fa-video-camera:before{content:"\f03d";}
.fa.fa-pencil:before{content:"\f303";}
.fa.fa-map-marker:before{content:"\f3c5";}
.fa.fa-pencil-square-o:before{content:"\f044";}
.fa.fa-share-square-o:before{content:"\f14d";}
.fa.fa-arrows:before{content:"\f0b2";}
.fa.fa-times-circle-o:before{content:"\f057";}
.fa.fa-check-circle-o:before{content:"\f058";}
.fa.fa-mail-forward:before{content:"\f064";}
.fa.fa-warning:before{content:"\f071";}
.fa.fa-calendar:before{content:"\f073";}
.fa.fa-arrows-v:before{content:"\f338";}
.fa.fa-arrows-h:before{content:"\f337";}
.fa.fa-gears:before{content:"\f085";}
.fa.fa-thumbs-o-up:before{content:"\f164";}
.fa.fa-thumbs-o-down:before{content:"\f165";}
.fa.fa-heart-o:before{content:"\f004";}
.fa.fa-sign-out:before{content:"\f2f5";}
.fa.fa-linkedin-square:before{content:"\f08c";}
.fa.fa-thumb-tack:before{content:"\f08d";}
.fa.fa-external-link:before{content:"\f35d";}
.fa.fa-sign-in:before{content:"\f2f6";}
.fa.fa-lemon-o:before{content:"\f094";}
.fa.fa-square-o:before{content:"\f0c8";}
.fa.fa-bookmark-o:before{content:"\f02e";}
.fa.fa-feed:before{content:"\f09e";}
.fa.fa-hdd-o:before{content:"\f0a0";}
.fa.fa-hand-o-right:before{content:"\f0a4";}
.fa.fa-hand-o-left:before{content:"\f0a5";}
.fa.fa-hand-o-up:before{content:"\f0a6";}
.fa.fa-hand-o-down:before{content:"\f0a7";}
.fa.fa-arrows-alt:before{content:"\f31e";}
.fa.fa-group:before{content:"\f0c0";}
.fa.fa-chain:before{content:"\f0c1";}
.fa.fa-scissors:before{content:"\f0c4";}
.fa.fa-files-o:before{content:"\f0c5";}
.fa.fa-floppy-o:before{content:"\f0c7";}
.fa.fa-navicon:before,.fa.fa-reorder:before{content:"\f0c9";}
.fa.fa-google-plus:before{content:"\f0d5";}
.fa.fa-money:before{content:"\f3d1";}
.fa.fa-unsorted:before{content:"\f0dc";}
.fa.fa-sort-desc:before{content:"\f0dd";}
.fa.fa-sort-asc:before{content:"\f0de";}
.fa.fa-linkedin:before{content:"\f0e1";}
.fa.fa-rotate-left:before{content:"\f0e2";}
.fa.fa-legal:before{content:"\f0e3";}
.fa.fa-dashboard:before,.fa.fa-tachometer:before{content:"\f3fd";}
.fa.fa-comment-o:before{content:"\f075";}
.fa.fa-comments-o:before{content:"\f086";}
.fa.fa-flash:before{content:"\f0e7";}
.fa.fa-paste:before{content:"\f328";}
.fa.fa-lightbulb-o:before{content:"\f0eb";}
.fa.fa-exchange:before{content:"\f362";}
.fa.fa-cloud-download:before{content:"\f381";}
.fa.fa-cloud-upload:before{content:"\f382";}
.fa.fa-bell-o:before{content:"\f0f3";}
.fa.fa-cutlery:before{content:"\f2e7";}
.fa.fa-building-o:before{content:"\f1ad";}
.fa.fa-hospital-o:before{content:"\f0f8";}
.fa.fa-tablet:before{content:"\f3fa";}
.fa.fa-mobile-phone:before,.fa.fa-mobile:before{content:"\f3cd";}
.fa.fa-mail-reply:before{content:"\f3e5";}
.fa.fa-folder-o:before{content:"\f07b";}
.fa.fa-folder-open-o:before{content:"\f07c";}
.fa.fa-smile-o:before{content:"\f118";}
.fa.fa-frown-o:before{content:"\f119";}
.fa.fa-meh-o:before{content:"\f11a";}
.fa.fa-keyboard-o:before{content:"\f11c";}
.fa.fa-flag-o:before{content:"\f024";}
.fa.fa-mail-reply-all:before{content:"\f122";}
.fa.fa-code-fork:before{content:"\f126";}
.fa.fa-chain-broken:before{content:"\f127";}
.fa.fa-shield:before{content:"\f3ed";}
.fa.fa-calendar-o:before{content:"\f133";}
.fa.fa-ticket:before{content:"\f3ff";}
.fa.fa-minus-square-o:before{content:"\f146";}
.fa.fa-level-up:before{content:"\f3bf";}
.fa.fa-level-down:before{content:"\f3be";}
.fa.fa-pencil-square:before{content:"\f14b";}
.fa.fa-external-link-square:before{content:"\f360";}
.fa.fa-eur:before,.fa.fa-euro:before{content:"\f153";}
.fa.fa-gbp:before{content:"\f154";}
.fa.fa-dollar:before,.fa.fa-usd:before{content:"\f155";}
.fa.fa-inr:before,.fa.fa-rupee:before{content:"\f156";}
.fa.fa-cny:before,.fa.fa-jpy:before,.fa.fa-rmb:before,.fa.fa-yen:before{content:"\f157";}
.fa.fa-rouble:before,.fa.fa-rub:before,.fa.fa-ruble:before{content:"\f158";}
.fa.fa-krw:before,.fa.fa-won:before{content:"\f159";}
.fa.fa-bitcoin:before{content:"\f15a";}
.fa.fa-sort-alpha-asc:before{content:"\f15d";}
.fa.fa-sort-alpha-desc:before{content:"\f15e";}
.fa.fa-sort-amount-asc:before{content:"\f160";}
.fa.fa-sort-amount-desc:before{content:"\f161";}
.fa.fa-sort-numeric-asc:before{content:"\f162";}
.fa.fa-sort-numeric-desc:before{content:"\f163";}
.fa.fa-youtube-play:before{content:"\f167";}
.fa.fa-bitbucket-square:before{content:"\f171";}
.fa.fa-long-arrow-down:before{content:"\f309";}
.fa.fa-long-arrow-up:before{content:"\f30c";}
.fa.fa-long-arrow-left:before{content:"\f30a";}
.fa.fa-long-arrow-right:before{content:"\f30b";}
.fa.fa-gittip:before{content:"\f184";}
.fa.fa-sun-o:before{content:"\f185";}
.fa.fa-moon-o:before{content:"\f186";}
.fa.fa-arrow-circle-o-right:before{content:"\f35a";}
.fa.fa-arrow-circle-o-left:before{content:"\f359";}
.fa.fa-dot-circle-o:before{content:"\f192";}
.fa.fa-try:before,.fa.fa-turkish-lira:before{content:"\f195";}
.fa.fa-plus-square-o:before{content:"\f0fe";}
.fa.fa-bank:before,.fa.fa-institution:before{content:"\f19c";}
.fa.fa-mortar-board:before{content:"\f19d";}
.fa.fa-spoon:before{content:"\f2e5";}
.fa.fa-automobile:before{content:"\f1b9";}
.fa.fa-cab:before{content:"\f1ba";}
.fa.fa-envelope-o:before{content:"\f0e0";}
.fa.fa-file-pdf-o:before{content:"\f1c1";}
.fa.fa-file-word-o:before{content:"\f1c2";}
.fa.fa-file-excel-o:before{content:"\f1c3";}
.fa.fa-file-powerpoint-o:before{content:"\f1c4";}
.fa.fa-file-code-o:before{content:"\f1c9";}
.fa.fa-circle-o-notch:before{content:"\f1ce";}
.fa.fa-ge:before{content:"\f1d1";}
.fa.fa-wechat:before{content:"\f1d7";}
.fa.fa-header:before{content:"\f1dc";}
.fa.fa-sliders:before{content:"\f1de";}
.fa.fa-newspaper-o:before{content:"\f1ea";}
.fa.fa-bell-slash-o:before{content:"\f1f6";}
.fa.fa-eyedropper:before{content:"\f1fb";}
.fa.fa-area-chart:before{content:"\f1fe";}
.fa.fa-pie-chart:before{content:"\f200";}
.fa.fa-line-chart:before{content:"\f201";}
.fa.fa-cc:before{content:"\f20a";}
.fa.fa-ils:before,.fa.fa-shekel:before,.fa.fa-sheqel:before{content:"\f20b";}
.fa.fa-diamond:before{content:"\f3a5";}
.fa.fa-intersex:before{content:"\f224";}
.fa.fa-facebook-official:before{content:"\f09a";}
.fa.fa-hotel:before{content:"\f236";}
.fa.fa-yc:before{content:"\f23b";}
.fa.fa-battery-4:before,.fa.fa-battery:before{content:"\f240";}
.fa.fa-battery-3:before{content:"\f241";}
.fa.fa-battery-2:before{content:"\f242";}
.fa.fa-battery-1:before{content:"\f243";}
.fa.fa-battery-0:before{content:"\f244";}
.fa.fa-sticky-note-o:before{content:"\f249";}
.fa.fa-hourglass-o:before{content:"\f254";}
.fa.fa-hourglass-1:before{content:"\f251";}
.fa.fa-hourglass-2:before{content:"\f252";}
.fa.fa-hourglass-3:before{content:"\f253";}
.fa.fa-hand-scissors-o:before{content:"\f257";}
.fa.fa-hand-lizard-o:before{content:"\f258";}
.fa.fa-hand-spock-o:before{content:"\f259";}
.fa.fa-hand-pointer-o:before{content:"\f25a";}
.fa.fa-hand-peace-o:before{content:"\f25b";}
.fa.fa-television:before{content:"\f26c";}
.fa.fa-calendar-plus-o:before{content:"\f271";}
.fa.fa-calendar-minus-o:before{content:"\f272";}
.fa.fa-calendar-times-o:before{content:"\f273";}
.fa.fa-calendar-check-o:before{content:"\f274";}
.fa.fa-map-o:before{content:"\f279";}
.fa.fa-vimeo:before{content:"\f27d";}
.fa.fa-credit-card-alt:before{content:"\f09d";}
.fa.fa-pause-circle-o:before{content:"\f28b";}
.fa.fa-stop-circle-o:before{content:"\f28d";}
.fa.fa-wheelchair-alt:before{content:"\f368";}
.fa.fa-question-circle-o:before{content:"\f059";}
.fa.fa-volume-control-phone:before{content:"\f2a0";}
.fa.fa-asl-interpreting:before{content:"\f2a3";}
.fa.fa-deafness:before,.fa.fa-hard-of-hearing:before{content:"\f2a4";}
.fa.fa-signing:before{content:"\f2a7";}
.fa.fa-handshake-o:before{content:"\f2b5";}
.fa.fa-envelope-open-o:before{content:"\f2b6";}
.fa.fa-address-book-o:before{content:"\f2b9";}
.fa.fa-user-circle-o:before{content:"\f2bd";}
.fa.fa-user-o:before{content:"\f007";}
.fa.fa-thermometer-4:before,.fa.fa-thermometer:before{content:"\f2c7";}
.fa.fa-thermometer-3:before{content:"\f2c8";}
.fa.fa-thermometer-2:before{content:"\f2c9";}
.fa.fa-thermometer-1:before{content:"\f2ca";}
.fa.fa-thermometer-0:before{content:"\f2cb";}
.fa.fa-bathtub:before,.fa.fa-s15:before{content:"\f2cd";}
.fa.fa-eercast:before{content:"\f2da";}
.fa.fa-snowflake-o:before{content:"\f2dc";}
.table td,.table th,.tab-matrix .container .hold .tabbed-top-contain .sticky-hold.opaque .table tr,#webform-client-form-11751 .select2-selection,#webform-client-form-10835 .select2-selection,#webform-client-form-13615 .select2-selection,#webform-client-form-13617 .select2-selection,#webform-client-form-11751 .form-control,#webform-client-form-10835 .form-control,#webform-client-form-13615 .form-control,#webform-client-form-13617 .form-control,#webform-client-form-11751 #webform-component-comments .form-control,#webform-client-form-10835 #webform-component-comments .form-control,#webform-client-form-13615 #webform-component-comments .form-control,#webform-client-form-13617 #webform-component-comments .form-control,.selector-panel li.active a.selector:hover,.selector-panel li.active a.selector:focus{background-color:#fff!important;}
.glyphicon-bitcoin:before,.glyphicon-btc:before,.glyphicon-xbt:before{content:"\e227";}
.glyphicon-yen:before,.glyphicon-jpy:before{content:"\00a5";}
.glyphicon-ruble:before,.glyphicon-rub:before{content:"\20bd";}

table,body>header .main-menu .navbar-collapse nav ul.menu.nav>li>a:hover,body>header .main-menu .navbar-collapse nav ul.menu.nav>li a:focus,body>header .main-menu .navbar-collapse nav ul.menu.nav>li a:active,.tab-matrix #block-block-313 .nav-tabs li a:focus,.tab-matrix #block-block-314 .nav-tabs li a:focus,.minimal-nav li a:focus{background-color:transparent;}
.table>thead>tr>th,.table>thead>tr>td,.table>tbody>tr>th,.table>tbody>tr>td,.table>tfoot>tr>th,.table>tfoot>tr>td,#ss360-results-container .panel-body .col-md-5 table td{line-height:1.428571429;vertical-align:top;border-top:1px solid #ddd;padding:8px;}
.table>caption+thead>tr:first-child>th,.table>caption+thead>tr:first-child>td,.table>colgroup+thead>tr:first-child>th,.table>colgroup+thead>tr:first-child>td,.table>thead:first-child>tr:first-child>th,.table>thead:first-child>tr:first-child>td,.panel>.table>tbody:first-child>tr:first-child th,.panel>.table>tbody:first-child>tr:first-child td,.panel-group .panel-footer{border-top:0;}
.table .table,.snapshot,.image-toggle-parent .image-toggle-buttons .image-toggler:hover,.tab-matrix .container .hold .tabbed-bottom-contain .table tr:last-of-type,.table-narrow tbody tr,.table-wide tbody tr,.table-long-text tbody tr,.card.flat-boxes,.card.colored.white .color-holder,.selector-panel li.active,#mela-trial-prog.webform-progressbar-wrapper-download.dark .webform-progressbar-outer .webform-progressbar-page{background-color:#fff;}
.table-bordered,.table-bordered>thead>tr>th,.table-bordered>thead>tr>td,.table-bordered>tbody>tr>th,.table-bordered>tbody>tr>td,.table-bordered>tfoot>tr>th,.table-bordered>tfoot>tr>td,.nav-tabs-justified>.active>a,.nav-tabs.nav-justified>.active>a,.nav-tabs-justified>.active>a:hover,.nav-tabs.nav-justified>.active>a:hover,.nav-tabs-justified>.active>a:focus,.nav-tabs.nav-justified>.active>a:focus{border:1px solid #ddd;}
.table-hover>tbody>tr:hover,.table>thead>tr>td.active,.table>thead>tr>th.active,.table>thead>tr.active>td,.table>thead>tr.active>th,.table>tbody>tr>td.active,.table>tbody>tr>th.active,.table>tbody>tr.active>td,.table>tbody>tr.active>th,.table>tfoot>tr>td.active,.table>tfoot>tr>th.active,.table>tfoot>tr.active>td,.table>tfoot>tr.active>th{background-color:#f5f5f5;}

.table-narrow .row-header,.table-wide .row-header,.table-long-text .row-header,.card.pale-cyan{background-color:#e4f5fd;}
.table-jambalaya tr:not(.divider):not(.text) td,.card .card-footer{border-top:1px solid #eaebec;}
.table-jambalaya tr.divider td .div-cell:last-of-type,.table-jambalaya tr.text>td>.row .list-hold:last-of-type{border-left:1px solid rgba(187,189,191,0.5);}
.purple-gradient a:not(.btn),.deep-grey-gradient a:not(.btn),.card.poster .card-body a:not(.btn),.section.waves a:not(.btn),.node-type-video .waves.field-name-body a:not(.btn),.section.deep-grey a:not(.btn),.node-type-video .deep-grey.field-name-body a:not(.btn){color:#fec10d!important;}
.fa.fa-meetup,.fa.fa-facebook-square,.fa.fa-twitter-square,.fa.fa-linkedin-square,.fa.fa-github-square,.fa.fa-facebook,.fa.fa-twitter,.fa.fa-facebook-f,.fa.fa-github,.fa.fa-google-plus,.fa.fa-google-plus-square,.fa.fa-pinterest,.fa.fa-pinterest-square,.fa.fa-linkedin,.fa.fa-github-alt,.fa.fa-css3,.fa.fa-html5,.fa.fa-maxcdn,.fa.fa-bitcoin,.fa.fa-btc,.fa.fa-xing,.fa.fa-xing-square,.fa.fa-youtube,.fa.fa-youtube-play,.fa.fa-youtube-square,.fa.fa-adn,.fa.fa-bitbucket,.fa.fa-bitbucket-square,.fa.fa-dropbox,.fa.fa-flickr,.fa.fa-instagram,.fa.fa-stack-overflow,.fa.fa-tumblr,.fa.fa-tumblr-square,.fa.fa-android,.fa.fa-apple,.fa.fa-dribbble,.fa.fa-foursquare,.fa.fa-gittip,.fa.fa-gratipay,.fa.fa-linux,.fa.fa-skype,.fa.fa-trello,.fa.fa-windows,.fa.fa-pagelines,.fa.fa-renren,.fa.fa-stack-exchange,.fa.fa-vk,.fa.fa-weibo,.fa.fa-vimeo-square,.fa.fa-openid,.fa.fa-slack,.fa.fa-wordpress,.fa.fa-delicious,.fa.fa-digg,.fa.fa-drupal,.fa.fa-google,.fa.fa-joomla,.fa.fa-pied-piper-alt,.fa.fa-pied-piper-pp,.fa.fa-reddit,.fa.fa-reddit-square,.fa.fa-stumbleupon,.fa.fa-stumbleupon-circle,.fa.fa-yahoo,.fa.fa-behance,.fa.fa-behance-square,.fa.fa-steam,.fa.fa-steam-square,.fa.fa-deviantart,.fa.fa-soundcloud,.fa.fa-codepen,.fa.fa-jsfiddle,.fa.fa-vine,.fa.fa-ra,.fa.fa-rebel,.fa.fa-resistance,.fa.fa-empire,.fa.fa-ge,.fa.fa-git,.fa.fa-git-square,.fa.fa-hacker-news,.fa.fa-y-combinator-square,.fa.fa-yc-square,.fa.fa-qq,.fa.fa-tencent-weibo,.fa.fa-wechat,.fa.fa-weixin,.fa.fa-slideshare,.fa.fa-twitch,.fa.fa-yelp,.fa.fa-cc-amex,.fa.fa-cc-discover,.fa.fa-cc-mastercard,.fa.fa-cc-paypal,.fa.fa-cc-stripe,.fa.fa-cc-visa,.fa.fa-google-wallet,.fa.fa-paypal,.fa.fa-angellist,.fa.fa-ioxhost,.fa.fa-lastfm,.fa.fa-lastfm-square,.fa.fa-meanpath,.fa.fa-buysellads,.fa.fa-connectdevelop,.fa.fa-dashcube,.fa.fa-forumbee,.fa.fa-leanpub,.fa.fa-sellsy,.fa.fa-shirtsinbulk,.fa.fa-simplybuilt,.fa.fa-skyatlas,.fa.fa-facebook-official,.fa.fa-pinterest-p,.fa.fa-whatsapp,.fa.fa-medium,.fa.fa-viacoin,.fa.fa-y-combinator,.fa.fa-yc,.fa.fa-expeditedssl,.fa.fa-opencart,.fa.fa-optin-monster,.fa.fa-cc-diners-club,.fa.fa-cc-jcb,.fa.fa-chrome,.fa.fa-creative-commons,.fa.fa-firefox,.fa.fa-get-pocket,.fa.fa-gg,.fa.fa-gg-circle,.fa.fa-internet-explorer,.fa.fa-odnoklassniki,.fa.fa-odnoklassniki-square,.fa.fa-opera,.fa.fa-safari,.fa.fa-tripadvisor,.fa.fa-wikipedia-w,.fa.fa-500px,.fa.fa-amazon,.fa.fa-contao,.fa.fa-houzz,.fa.fa-vimeo,.fa.fa-black-tie,.fa.fa-edge,.fa.fa-fonticons,.fa.fa-reddit-alien,.fa.fa-codiepie,.fa.fa-fort-awesome,.fa.fa-mixcloud,.fa.fa-modx,.fa.fa-product-hunt,.fa.fa-scribd,.fa.fa-usb,.fa.fa-bluetooth,.fa.fa-bluetooth-b,.fa.fa-envira,.fa.fa-gitlab,.fa.fa-wheelchair-alt,.fa.fa-wpbeginner,.fa.fa-wpforms,.fa.fa-glide,.fa.fa-glide-g,.fa.fa-first-order,.fa.fa-google-plus-official,.fa.fa-pied-piper,.fa.fa-snapchat,.fa.fa-snapchat-ghost,.fa.fa-snapchat-square,.fa.fa-themeisle,.fa.fa-viadeo,.fa.fa-viadeo-square,.fa.fa-yoast,.fa.fa-google-plus-circle,.fa.fa-fa,.fa.fa-font-awesome,.fa.fa-linode,.fa.fa-free-code-camp,.fa.fa-quora,.fa.fa-telegram,.fa.fa-bandcamp,.fa.fa-eercast,.fa.fa-etsy,.fa.fa-grav,.fa.fa-imdb,.fa.fa-ravelry,.fa.fa-spotify,.fa.fa-superpowers,.fa.fa-wpexplorer{font-family:"Font Awesome 5 Brands";font-weight:400;}
.fa.fa-star-o,.fa.fa-trash-o,.fa.fa-file-o,.fa.fa-clock-o,.fa.fa-arrow-circle-o-down,.fa.fa-arrow-circle-o-up,.fa.fa-play-circle-o,.fa.fa-list-alt,.fa.fa-picture-o,.fa.fa-photo,.fa.fa-image,.fa.fa-pencil-square-o,.fa.fa-share-square-o,.fa.fa-check-square-o,.fa.fa-times-circle-o,.fa.fa-check-circle-o,.fa.fa-eye,.fa.fa-eye-slash,.fa.fa-bar-chart,.fa.fa-bar-chart-o,.fa.fa-thumbs-o-up,.fa.fa-thumbs-o-down,.fa.fa-heart-o,.fa.fa-lemon-o,.fa.fa-square-o,.fa.fa-bookmark-o,.fa.fa-credit-card,.fa.fa-hdd-o,.fa.fa-hand-o-right,.fa.fa-hand-o-left,.fa.fa-hand-o-up,.fa.fa-hand-o-down,.fa.fa-files-o,.fa.fa-floppy-o,.fa.fa-money,.fa.fa-comment-o,.fa.fa-comments-o,.fa.fa-clipboard,.fa.fa-paste,.fa.fa-lightbulb-o,.fa.fa-bell-o,.fa.fa-file-text-o,.fa.fa-building-o,.fa.fa-hospital-o,.fa.fa-circle-o,.fa.fa-folder-o,.fa.fa-folder-open-o,.fa.fa-smile-o,.fa.fa-frown-o,.fa.fa-meh-o,.fa.fa-keyboard-o,.fa.fa-flag-o,.fa.fa-star-half-o,.fa.fa-star-half-empty,.fa.fa-star-half-full,.fa.fa-calendar-o,.fa.fa-minus-square-o,.fa.fa-compass,.fa.fa-caret-square-o-down,.fa.fa-toggle-down,.fa.fa-caret-square-o-up,.fa.fa-toggle-up,.fa.fa-caret-square-o-right,.fa.fa-toggle-right,.fa.fa-sun-o,.fa.fa-moon-o,.fa.fa-arrow-circle-o-right,.fa.fa-arrow-circle-o-left,.fa.fa-caret-square-o-left,.fa.fa-toggle-left,.fa.fa-dot-circle-o,.fa.fa-plus-square-o,.fa.fa-envelope-o,.fa.fa-file-pdf-o,.fa.fa-file-word-o,.fa.fa-file-excel-o,.fa.fa-file-powerpoint-o,.fa.fa-file-image-o,.fa.fa-file-photo-o,.fa.fa-file-picture-o,.fa.fa-file-archive-o,.fa.fa-file-zip-o,.fa.fa-file-audio-o,.fa.fa-file-sound-o,.fa.fa-file-video-o,.fa.fa-file-movie-o,.fa.fa-file-code-o,.fa.fa-life-bouy,.fa.fa-life-ring,.fa.fa-life-buoy,.fa.fa-life-saver,.fa.fa-support,.fa.fa-paper-plane-o,.fa.fa-send-o,.fa.fa-circle-thin,.fa.fa-futbol-o,.fa.fa-soccer-ball-o,.fa.fa-newspaper-o,.fa.fa-bell-slash-o,.fa.fa-copyright,.fa.fa-cc,.fa.fa-diamond,.fa.fa-object-group,.fa.fa-object-ungroup,.fa.fa-sticky-note-o,.fa.fa-clone,.fa.fa-hourglass-o,.fa.fa-hand-rock-o,.fa.fa-hand-grab-o,.fa.fa-hand-paper-o,.fa.fa-hand-stop-o,.fa.fa-hand-scissors-o,.fa.fa-hand-lizard-o,.fa.fa-hand-spock-o,.fa.fa-hand-pointer-o,.fa.fa-hand-peace-o,.fa.fa-registered,.fa.fa-calendar-plus-o,.fa.fa-calendar-minus-o,.fa.fa-calendar-times-o,.fa.fa-calendar-check-o,.fa.fa-map-o,.fa.fa-commenting,.fa.fa-commenting-o,.fa.fa-pause-circle-o,.fa.fa-stop-circle-o,.fa.fa-question-circle-o,.fa.fa-handshake-o,.fa.fa-envelope-open-o,.fa.fa-address-book-o,.fa.fa-address-card-o,.fa.fa-vcard-o,.fa.fa-user-circle-o,.fa.fa-user-o,.fa.fa-id-badge,.fa.fa-id-card-o,.fa.fa-drivers-license-o,.fa.fa-window-maximize,.fa.fa-window-restore,.fa.fa-window-close-o,.fa.fa-times-rectangle-o,.fa.fa-snowflake-o{font-family:"Font Awesome 5 Pro";font-weight:400;}
.fa.fa-trash-o:before,.fa.fa-trash:before{content:"\f2ed";}
.fa.fa-picture-o:before,.fa.fa-photo:before,.fa.fa-image:before{content:"\f03e";}
.fa.fa-bar-chart:before,.fa.fa-bar-chart-o:before{content:"\f080";}
.fa.fa-facebook:before,.fa.fa-facebook-f:before{content:"\f39e";}
.fa.fa-file-text-o:before,.fa.fa-file-text:before{content:"\f15c";}
.fa.fa-circle-o:before,.fa.fa-circle-thin:before{content:"\f111";}
.fa.fa-star-half-o:before,.fa.fa-star-half-empty:before,.fa.fa-star-half-full:before{content:"\f089";}
.fa.fa-caret-square-o-down:before,.fa.fa-toggle-down:before{content:"\f150";}
.fa.fa-caret-square-o-up:before,.fa.fa-toggle-up:before{content:"\f151";}
.fa.fa-caret-square-o-right:before,.fa.fa-toggle-right:before{content:"\f152";}
.fa.fa-caret-square-o-left:before,.fa.fa-toggle-left:before{content:"\f191";}
.fa.fa-file-image-o:before,.fa.fa-file-photo-o:before,.fa.fa-file-picture-o:before{content:"\f1c5";}
.fa.fa-file-archive-o:before,.fa.fa-file-zip-o:before{content:"\f1c6";}
.fa.fa-file-audio-o:before,.fa.fa-file-sound-o:before{content:"\f1c7";}
.fa.fa-file-video-o:before,.fa.fa-file-movie-o:before{content:"\f1c8";}
.fa.fa-life-bouy:before,.fa.fa-life-buoy:before,.fa.fa-life-saver:before,.fa.fa-support:before{content:"\f1cd";}
.fa.fa-ra:before,.fa.fa-resistance:before{content:"\f1d0";}
.fa.fa-y-combinator-square:before,.fa.fa-yc-square:before{content:"\f1d4";}
.fa.fa-send:before,.fa.fa-paper-plane-o:before,.fa.fa-send-o:before{content:"\f1d8";}
.fa.fa-futbol-o:before,.fa.fa-soccer-ball-o:before{content:"\f1e3";}
.fa.fa-meanpath:before,.fa.fa-fa:before{content:"\f2b4";}
.fa.fa-hand-rock-o:before,.fa.fa-hand-grab-o:before{content:"\f255";}
.fa.fa-hand-paper-o:before,.fa.fa-hand-stop-o:before{content:"\f256";}
.fa.fa-commenting:before,.fa.fa-commenting-o:before{content:"\f4ad";}
.fa.fa-google-plus-official:before,.fa.fa-google-plus-circle:before{content:"\f2b3";}
.fa.fa-vcard:before,.fa.fa-address-card-o:before,.fa.fa-vcard-o:before{content:"\f2bb";}
.fa.fa-drivers-license:before,.fa.fa-id-card-o:before,.fa.fa-drivers-license-o:before{content:"\f2c2";}
.fa.fa-times-rectangle:before,.fa.fa-window-close-o:before,.fa.fa-times-rectangle-o:before{content:"\f410";}
@media min-width768px {
.lead{font-size:24px;}
.dl-horizontal dt{float:left;width:160px;clear:left;text-align:right;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
.dl-horizontal dd{margin-left:180px;}
.container{width:750px;}
.col-sm-1,.col-sm-2,.col-sm-3,.col-sm-4,.col-sm-5,.col-sm-6,.col-sm-7,.col-sm-8,.col-sm-9,.col-sm-10,.col-sm-11,.col-sm-12{float:left;}
.col-sm-1{width:8.3333333333%;}
.col-sm-2{width:16.6666666667%;}
.col-sm-3{width:25%;}
.col-sm-4{width:33.3333333333%;}
.col-sm-5{width:41.6666666667%;}
.col-sm-6{width:50%;}
.col-sm-7{width:58.3333333333%;}
.col-sm-8{width:66.6666666667%;}
.col-sm-9{width:75%;}
.col-sm-10{width:83.3333333333%;}
.col-sm-11{width:91.6666666667%;}
.col-sm-pull-0{right:auto;}
.col-sm-pull-1{right:8.3333333333%;}
.col-sm-pull-2{right:16.6666666667%;}
.col-sm-pull-3{right:25%;}
.col-sm-pull-4{right:33.3333333333%;}
.col-sm-pull-5{right:41.6666666667%;}
.col-sm-pull-6{right:50%;}
.col-sm-pull-7{right:58.3333333333%;}
.col-sm-pull-8{right:66.6666666667%;}
.col-sm-pull-9{right:75%;}
.col-sm-pull-10{right:83.3333333333%;}
.col-sm-pull-11{right:91.6666666667%;}
.col-sm-pull-12{right:100%;}
.col-sm-push-0{left:auto;}
.col-sm-push-1{left:8.3333333333%;}
.col-sm-push-2{left:16.6666666667%;}
.col-sm-push-3{left:25%;}
.col-sm-push-4{left:33.3333333333%;}
.col-sm-push-5{left:41.6666666667%;}
.col-sm-push-6{left:50%;}
.col-sm-push-7{left:58.3333333333%;}
.col-sm-push-8{left:66.6666666667%;}
.col-sm-push-9{left:75%;}
.col-sm-push-10{left:83.3333333333%;}
.col-sm-push-11{left:91.6666666667%;}
.col-sm-push-12{left:100%;}
.col-sm-offset-0{margin-left:0;}
.col-sm-offset-1{margin-left:8.3333333333%;}
.col-sm-offset-2{margin-left:16.6666666667%;}
.col-sm-offset-3{margin-left:25%;}
.col-sm-offset-4{margin-left:33.3333333333%;}
.col-sm-offset-5{margin-left:41.6666666667%;}
.col-sm-offset-6{margin-left:50%;}
.col-sm-offset-7{margin-left:58.3333333333%;}
.col-sm-offset-8{margin-left:66.6666666667%;}
.col-sm-offset-9{margin-left:75%;}
.col-sm-offset-10{margin-left:83.3333333333%;}
.col-sm-offset-11{margin-left:91.6666666667%;}
.col-sm-offset-12{margin-left:100%;}
.top-image .views-field-field-put-title-in-top-image .field-content h1#top-image-title,.page-node-17233 h1,.page-node-17233 .ss360-content-container,.page-node-17233 .ss360-content-container p,.page-node-12878.gray-body .region-content .block-webform{float:left;width:100%;}
}
@media min-width992px {
.container{width:970px;}
.col-md-1,.col-md-2,.col-md-3,.col-md-4,.col-md-5,.col-md-6,.col-md-7,.col-md-8,.col-md-9,.col-md-10,.col-md-11,.col-md-12{float:left;}
.col-md-1{width:8.3333333333%;}
.col-md-2{width:16.6666666667%;}
.col-md-3{width:25%;}
.col-md-4{width:33.3333333333%;}
.col-md-5{width:41.6666666667%;}
.col-md-6{width:50%;}
.col-md-7{width:58.3333333333%;}
.col-md-8{width:66.6666666667%;}
.col-md-9{width:75%;}
.col-md-10{width:83.3333333333%;}
.col-md-11{width:91.6666666667%;}
.col-md-12{width:100%;}
.col-md-pull-0{right:auto;}
.col-md-pull-1{right:8.3333333333%;}
.col-md-pull-2{right:16.6666666667%;}
.col-md-pull-3{right:25%;}
.col-md-pull-4{right:33.3333333333%;}
.col-md-pull-5{right:41.6666666667%;}
.col-md-pull-6{right:50%;}
.col-md-pull-7{right:58.3333333333%;}
.col-md-pull-8{right:66.6666666667%;}
.col-md-pull-9{right:75%;}
.col-md-pull-10{right:83.3333333333%;}
.col-md-pull-11{right:91.6666666667%;}
.col-md-pull-12{right:100%;}
.col-md-push-0{left:auto;}
.col-md-push-2{left:16.6666666667%;}
.col-md-push-5{left:41.6666666667%;}
.col-md-push-6{left:50%;}
.col-md-push-7{left:58.3333333333%;}
.col-md-push-8{left:66.6666666667%;}
.col-md-push-9{left:75%;}
.col-md-push-10{left:83.3333333333%;}
.col-md-push-11{left:91.6666666667%;}
.col-md-push-12{left:100%;}
.col-md-offset-0{margin-left:0;}
.col-md-offset-1{margin-left:8.3333333333%;}
.col-md-offset-3{margin-left:25%;}
.col-md-offset-4{margin-left:33.3333333333%;}
.col-md-offset-5{margin-left:41.6666666667%;}
.col-md-offset-6{margin-left:50%;}
.col-md-offset-7{margin-left:58.3333333333%;}
.col-md-offset-8{margin-left:66.6666666667%;}
.col-md-offset-9{margin-left:75%;}
.col-md-offset-10{margin-left:83.3333333333%;}
.col-md-offset-11{margin-left:91.6666666667%;}
.col-md-offset-12{margin-left:100%;}
.modal-lg{width:900px;}
#webform-client-form-11751 #webform-component-promo,#webform-client-form-11751 #webform-component-partner-type-select,#webform-client-form-11751 #webform-component-update-partner,#webform-client-form-11751 #webform-component-distibutor-details,#webform-client-form-11751 #webform-component-partener-reseller-details,#webform-client-form-11751 #webform-component-distributor,#webform-client-form-11751 #webform-component-end-customer-details,#webform-client-form-11751 #webform-component-project-fieldset,#webform-client-form-11751 #webform-component-environment,#webform-client-form-11751 #webform-component-products,#webform-client-form-11751 #webform-component-functionality-required,#webform-client-form-11751 #webform-component-will-this-use-mela,#webform-client-form-10835 #webform-component-promo,#webform-client-form-10835 #webform-component-partner-type-select,#webform-client-form-10835 #webform-component-update-partner,#webform-client-form-10835 #webform-component-distibutor-details,#webform-client-form-10835 #webform-component-partener-reseller-details,#webform-client-form-10835 #webform-component-distributor,#webform-client-form-10835 #webform-component-end-customer-details,#webform-client-form-10835 #webform-component-project-fieldset,#webform-client-form-10835 #webform-component-environment,#webform-client-form-10835 #webform-component-products,#webform-client-form-10835 #webform-component-functionality-required,#webform-client-form-10835 #webform-component-will-this-use-mela,#webform-client-form-13615 #webform-component-promo,#webform-client-form-13615 #webform-component-partner-type-select,#webform-client-form-13615 #webform-component-update-partner,#webform-client-form-13615 #webform-component-distibutor-details,#webform-client-form-13615 #webform-component-partener-reseller-details,#webform-client-form-13615 #webform-component-distributor,#webform-client-form-13615 #webform-component-end-customer-details,#webform-client-form-13615 #webform-component-project-fieldset,#webform-client-form-13615 #webform-component-environment,#webform-client-form-13615 #webform-component-products,#webform-client-form-13615 #webform-component-functionality-required,#webform-client-form-13615 #webform-component-will-this-use-mela,#webform-client-form-13617 #webform-component-promo,#webform-client-form-13617 #webform-component-partner-type-select,#webform-client-form-13617 #webform-component-update-partner,#webform-client-form-13617 #webform-component-distibutor-details,#webform-client-form-13617 #webform-component-partener-reseller-details,#webform-client-form-13617 #webform-component-distributor,#webform-client-form-13617 #webform-component-end-customer-details,#webform-client-form-13617 #webform-component-project-fieldset,#webform-client-form-13617 #webform-component-environment,#webform-client-form-13617 #webform-component-products,#webform-client-form-13617 #webform-component-functionality-required,#webform-client-form-13617 #webform-component-will-this-use-mela{float:left;width:83.3333333333%;left:8.3333333333%;}
.webform-progressbar-wrapper-download .webform-progressbar-outer{float:left;width:66.6666666667%;left:16.6666666667%;}
.page-node-12878.gray-body .region-content .block-webform{float:left;width:41.6666666667%;}
.col-md-push-1,#webform-client-form-11751 #webform-component-partner-type-select .form-item:first-child,#webform-client-form-10835 #webform-component-partner-type-select .form-item:first-child,#webform-client-form-13615 #webform-component-partner-type-select .form-item:first-child,#webform-client-form-13617 #webform-component-partner-type-select .form-item:first-child{left:8.3333333333%;}
.col-md-push-3,#webform-client-form-11751 #webform-component-partner-type-select .form-item:last-child,#webform-client-form-10835 #webform-component-partner-type-select .form-item:last-child,#webform-client-form-13615 #webform-component-partner-type-select .form-item:last-child,#webform-client-form-13617 #webform-component-partner-type-select .form-item:last-child{left:25%;}
.col-md-push-4,.form-type-password-confirm .password-help{left:33.3333333333%;}
.col-md-offset-2,.page-node-12878.gray-body .region-content .block-webform:last-of-type{margin-left:16.6666666667%;}
.top-image .views-field-field-put-title-in-top-image .field-content h1#top-image-title,#webform-client-form-11751 #webform-component-update-partner .form-group,#webform-client-form-11751 #webform-component-distibutor-details .form-group,#webform-client-form-10835 #webform-component-update-partner .form-group,#webform-client-form-10835 #webform-component-distibutor-details .form-group,#webform-client-form-13615 #webform-component-update-partner .form-group,#webform-client-form-13615 #webform-component-distibutor-details .form-group,#webform-client-form-13617 #webform-component-update-partner .form-group,#webform-client-form-13617 #webform-component-distibutor-details .form-group,#webform-client-form-11751 #webform-component-end-customer-details--state,#webform-client-form-11751 #webform-component-partener-reseller-details--reseller-partner-company-name,#webform-client-form-11751 #webform-component-partener-reseller-details--partner-email,#webform-client-form-11751 #webform-component-partener-reseller-details--partner-phone,#webform-client-form-11751 #webform-component-partener-reseller-details--partener-contact-name,#webform-client-form-11751 #webform-component-partener-reseller-details--potential-competitors,#webform-client-form-11751 #webform-component-partener-reseller-details--if-distributor-which .form-item,#webform-client-form-10835 #webform-component-end-customer-details--state,#webform-client-form-10835 #webform-component-partener-reseller-details--reseller-partner-company-name,#webform-client-form-10835 #webform-component-partener-reseller-details--partner-email,#webform-client-form-10835 #webform-component-partener-reseller-details--partner-phone,#webform-client-form-10835 #webform-component-partener-reseller-details--partener-contact-name,#webform-client-form-10835 #webform-component-partener-reseller-details--potential-competitors,#webform-client-form-10835 #webform-component-partener-reseller-details--if-distributor-which .form-item,#webform-client-form-13615 #webform-component-end-customer-details--state,#webform-client-form-13615 #webform-component-partener-reseller-details--reseller-partner-company-name,#webform-client-form-13615 #webform-component-partener-reseller-details--partner-email,#webform-client-form-13615 #webform-component-partener-reseller-details--partner-phone,#webform-client-form-13615 #webform-component-partener-reseller-details--partener-contact-name,#webform-client-form-13615 #webform-component-partener-reseller-details--potential-competitors,#webform-client-form-13615 #webform-component-partener-reseller-details--if-distributor-which .form-item,#webform-client-form-13617 #webform-component-end-customer-details--state,#webform-client-form-13617 #webform-component-partener-reseller-details--reseller-partner-company-name,#webform-client-form-13617 #webform-component-partener-reseller-details--partner-email,#webform-client-form-13617 #webform-component-partener-reseller-details--partner-phone,#webform-client-form-13617 #webform-component-partener-reseller-details--partener-contact-name,#webform-client-form-13617 #webform-component-partener-reseller-details--potential-competitors,#webform-client-form-13617 #webform-component-partener-reseller-details--if-distributor-which .form-item,#webform-client-form-11751 #webform-component-distributor .form-group,#webform-client-form-10835 #webform-component-distributor .form-group,#webform-client-form-13615 #webform-component-distributor .form-group,#webform-client-form-13617 #webform-component-distributor .form-group,#webform-client-form-11751 #webform-component-end-customer-details--company,#webform-client-form-11751 #webform-component-end-customer-details--name,#webform-client-form-11751 #webform-component-end-customer-details--email,#webform-client-form-11751 #webform-component-end-customer-details--phone,#webform-client-form-11751 #webform-component-end-customer-details--expected-closing-date,#webform-client-form-11751 #webform-component-end-customer-details--country,#webform-client-form-10835 #webform-component-end-customer-details--company,#webform-client-form-10835 #webform-component-end-customer-details--name,#webform-client-form-10835 #webform-component-end-customer-details--email,#webform-client-form-10835 #webform-component-end-customer-details--phone,#webform-client-form-10835 #webform-component-end-customer-details--expected-closing-date,#webform-client-form-10835 #webform-component-end-customer-details--country,#webform-client-form-13615 #webform-component-end-customer-details--company,#webform-client-form-13615 #webform-component-end-customer-details--name,#webform-client-form-13615 #webform-component-end-customer-details--email,#webform-client-form-13615 #webform-component-end-customer-details--phone,#webform-client-form-13615 #webform-component-end-customer-details--expected-closing-date,#webform-client-form-13615 #webform-component-end-customer-details--country,#webform-client-form-13617 #webform-component-end-customer-details--company,#webform-client-form-13617 #webform-component-end-customer-details--name,#webform-client-form-13617 #webform-component-end-customer-details--email,#webform-client-form-13617 #webform-component-end-customer-details--phone,#webform-client-form-13617 #webform-component-end-customer-details--expected-closing-date,#webform-client-form-13617 #webform-component-end-customer-details--country,#webform-client-form-11751 #webform-component-environment--environment-col-6,#webform-client-form-11751 #webform-component-environment--environment-col-6-2,#webform-client-form-10835 #webform-component-environment--environment-col-6,#webform-client-form-10835 #webform-component-environment--environment-col-6-2,#webform-client-form-13615 #webform-component-environment--environment-col-6,#webform-client-form-13615 #webform-component-environment--environment-col-6-2,#webform-client-form-13617 #webform-component-environment--environment-col-6,#webform-client-form-13617 #webform-component-environment--environment-col-6-2,#webform-client-form-11751 #webform-component-products--product-interest,#webform-client-form-10835 #webform-component-products--product-interest,#webform-client-form-13615 #webform-component-products--product-interest,#webform-client-form-13617 #webform-component-products--product-interest,#webform-client-form-11751 #webform-component-products--callout,#webform-client-form-10835 #webform-component-products--callout,#webform-client-form-13615 #webform-component-products--callout,#webform-client-form-13617 #webform-component-products--callout,.page-node-17231 .ss360-group li{float:left;width:50%;}
.node-type-case #block-menu-menu-more-resources,.node-type-case #block-menu-menu-media,.node-type-case #block-menu-menu-community,.page-load-balancing-webinars-and-videos #block-menu-menu-more-resources,.page-load-balancing-webinars-and-videos #block-menu-menu-media,.page-load-balancing-webinars-and-videos #block-menu-menu-community,.page-load-balancing-webinars-slideshows #block-menu-menu-more-resources,.page-load-balancing-webinars-slideshows #block-menu-menu-media,.page-load-balancing-webinars-slideshows #block-menu-menu-community,#webform-client-form-11751 #webform-component-partner-type-select .form-item,#webform-client-form-10835 #webform-component-partner-type-select .form-item,#webform-client-form-13615 #webform-component-partner-type-select .form-item,#webform-client-form-13617 #webform-component-partner-type-select .form-item,.page-node-17233 .ss360-group li{float:left;width:33.3333333333%;}
#webform-client-form-11751 #webform-component-products--callout--schedule-callback--schedule-a-callback,#webform-client-form-10835 #webform-component-products--callout--schedule-callback--schedule-a-callback,#webform-client-form-13615 #webform-component-products--callout--schedule-callback--schedule-a-callback,#webform-client-form-13617 #webform-component-products--callout--schedule-callback--schedule-a-callback,#webform-client-form-11751 #webform-component-product-interest--callout--schedule-a-callback,#webform-client-form-10835 #webform-component-product-interest--callout--schedule-a-callback,#webform-client-form-13615 #webform-component-product-interest--callout--schedule-a-callback,#webform-client-form-13617 #webform-component-product-interest--callout--schedule-a-callback{float:left;width:75%;}
#webform-client-form-11751 #webform-component-products--callout--schedule-callback--select-a-time,#webform-client-form-10835 #webform-component-products--callout--schedule-callback--select-a-time,#webform-client-form-13615 #webform-component-products--callout--schedule-callback--select-a-time,#webform-client-form-13617 #webform-component-products--callout--schedule-callback--select-a-time,#webform-client-form-11751 #webform-component-products--callout--schedule-callback--callback-selection,#webform-client-form-10835 #webform-component-products--callout--schedule-callback--callback-selection,#webform-client-form-13615 #webform-component-products--callout--schedule-callback--callback-selection,#webform-client-form-13617 #webform-component-products--callout--schedule-callback--callback-selection,#webform-client-form-11751 #webform-component-products--callout--schedule-callback--select-a-date,#webform-client-form-10835 #webform-component-products--callout--schedule-callback--select-a-date,#webform-client-form-13615 #webform-component-products--callout--schedule-callback--select-a-date,#webform-client-form-13617 #webform-component-products--callout--schedule-callback--select-a-date,.page-node-11751 .progressbar-wrapper .webform-progressbar-outer,.page-node-10835 .progressbar-wrapper .webform-progressbar-outer,.page-node-13615 .progressbar-wrapper .webform-progressbar-outer,.page-node-13617 .progressbar-wrapper .webform-progressbar-outer,.page-node-17233 h1,.page-node-17233 .ss360-content-container,.page-node-17233 .ss360-content-container p{float:left;width:100%;}
}
@media min-width1200px {
.container{width:1170px;}
.col-lg-1{width:8.3333333333%;}
.col-lg-2{width:16.6666666667%;}
.col-lg-3{width:25%;}
.col-lg-4{width:33.3333333333%;}
.col-lg-5{width:41.6666666667%;}
.col-lg-6{width:50%;}
.col-lg-7{width:58.3333333333%;}
.col-lg-8{width:66.6666666667%;}
.col-lg-9{width:75%;}
.col-lg-10{width:83.3333333333%;}
.col-lg-11{width:91.6666666667%;}
.col-lg-12{width:100%;}
.col-lg-pull-0{right:auto;}
.col-lg-pull-1{right:8.3333333333%;}
.col-lg-pull-2{right:16.6666666667%;}
.col-lg-pull-3{right:25%;}
.col-lg-pull-4{right:33.3333333333%;}
.col-lg-pull-5{right:41.6666666667%;}
.col-lg-pull-6{right:50%;}
.col-lg-pull-7{right:58.3333333333%;}
.col-lg-pull-8{right:66.6666666667%;}
.col-lg-pull-9{right:75%;}
.col-lg-pull-10{right:83.3333333333%;}
.col-lg-pull-11{right:91.6666666667%;}
.col-lg-pull-12{right:100%;}
.col-lg-push-0{left:auto;}
.col-lg-push-1{left:8.3333333333%;}
.col-lg-push-2{left:16.6666666667%;}
.col-lg-push-3{left:25%;}
.col-lg-push-4{left:33.3333333333%;}
.col-lg-push-5{left:41.6666666667%;}
.col-lg-push-6{left:50%;}
.col-lg-push-7{left:58.3333333333%;}
.col-lg-push-8{left:66.6666666667%;}
.col-lg-push-9{left:75%;}
.col-lg-push-10{left:83.3333333333%;}
.col-lg-push-11{left:91.6666666667%;}
.col-lg-push-12{left:100%;}
.col-lg-offset-0{margin-left:0;}
.col-lg-offset-1{margin-left:8.3333333333%;}
.col-lg-offset-2{margin-left:16.6666666667%;}
.col-lg-offset-3{margin-left:25%;}
.col-lg-offset-4{margin-left:33.3333333333%;}
.col-lg-offset-5{margin-left:41.6666666667%;}
.col-lg-offset-6{margin-left:50%;}
.col-lg-offset-7{margin-left:58.3333333333%;}
.col-lg-offset-8{margin-left:66.6666666667%;}
.col-lg-offset-9{margin-left:75%;}
.col-lg-offset-10{margin-left:83.3333333333%;}
.col-lg-offset-11{margin-left:91.6666666667%;}
.col-lg-offset-12{margin-left:100%;}
.navbar-right .dropdown-menu{right:0;left:auto;}
.navbar-right .dropdown-menu-left{left:0;right:auto;}
.navbar{border-radius:4px;}
.navbar-collapse{width:auto;border-top:0;box-shadow:none;}
.navbar-collapse.collapse{display:block!important;height:auto!important;padding-bottom:0;overflow:visible!important;}
.navbar-collapse.in{overflow-y:visible;}
.navbar-fixed-top .navbar-collapse,.navbar-static-top .navbar-collapse,.navbar-fixed-bottom .navbar-collapse{padding-left:0;padding-right:0;}
.container>.navbar-header,.container>.navbar-collapse,.container-fluid>.navbar-header,.container-fluid>.navbar-collapse{margin-right:0;margin-left:0;}
.navbar>.container .navbar-brand,.navbar>.container-fluid .navbar-brand{margin-left:-15px;}
table.visible-lg{display:table!important;}
tr.visible-lg{display:table-row!important;}
th.visible-lg,td.visible-lg{display:table-cell!important;}
.visible-lg-inline{display:inline!important;}
.visible-lg-inline-block{display:inline-block!important;}
.hidden-lg{display:none!important;}
.col-lg-1,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9,.col-lg-10,.col-lg-11,.col-lg-12,.navbar-header{float:left;}
.navbar-static-top,.navbar-fixed-top,.navbar-fixed-bottom{border-radius:0;}
.visible-lg,.visible-lg-block{display:block!important;}
}
@media screen and max-width767px {
.table-responsive{width:100%;margin-bottom:15px;overflow-y:hidden;-ms-overflow-style:0;border:1px solid #ddd;}
.table-responsive>.table{margin-bottom:0;}
.table-responsive>.table>thead>tr>th,.table-responsive>.table>thead>tr>td,.table-responsive>.table>tbody>tr>th,.table-responsive>.table>tbody>tr>td,.table-responsive>.table>tfoot>tr>th,.table-responsive>.table>tfoot>tr>td{white-space:nowrap;}
.table-responsive>.table-bordered{border:0;}
.table-responsive>.table-bordered>thead>tr>th:first-child,.table-responsive>.table-bordered>thead>tr>td:first-child,.table-responsive>.table-bordered>tbody>tr>th:first-child,.table-responsive>.table-bordered>tbody>tr>td:first-child,.table-responsive>.table-bordered>tfoot>tr>th:first-child,.table-responsive>.table-bordered>tfoot>tr>td:first-child{border-left:0;}
.table-responsive>.table-bordered>thead>tr>th:last-child,.table-responsive>.table-bordered>thead>tr>td:last-child,.table-responsive>.table-bordered>tbody>tr>th:last-child,.table-responsive>.table-bordered>tbody>tr>td:last-child,.table-responsive>.table-bordered>tfoot>tr>th:last-child,.table-responsive>.table-bordered>tfoot>tr>td:last-child{border-right:0;}
.table-responsive>.table-bordered>tbody>tr:last-child>th,.table-responsive>.table-bordered>tbody>tr:last-child>td,.table-responsive>.table-bordered>tfoot>tr:last-child>th,.table-responsive>.table-bordered>tfoot>tr:last-child>td{border-bottom:0;}
}
@media screen and -webkit-min-device-pixel-ratio0 {
input[type="date"].form-control,input[type="time"].form-control,input[type="datetime-local"].form-control,input[type="month"].form-control{line-height:34px;}
input[type="date"].input-sm,.input-group-sm>input[type="date"].form-control,.input-group-sm>input[type="date"].input-group-addon,.input-group-sm>.input-group-btn>input[type="date"].btn,.input-group-sm input[type="date"],input[type="time"].input-sm,.input-group-sm>input[type="time"].form-control,.input-group-sm>input[type="time"].input-group-addon,.input-group-sm>.input-group-btn>input[type="time"].btn,.input-group-sm input[type="time"],input[type="datetime-local"].input-sm,.input-group-sm>input[type="datetime-local"].form-control,.input-group-sm>input[type="datetime-local"].input-group-addon,.input-group-sm>.input-group-btn>input[type="datetime-local"].btn,.input-group-sm input[type="datetime-local"],input[type="month"].input-sm,.input-group-sm>input[type="month"].form-control,.input-group-sm>input[type="month"].input-group-addon,.input-group-sm>.input-group-btn>input[type="month"].btn,.input-group-sm input[type="month"]{line-height:30px;}
input[type="date"].input-lg,.input-group-lg>input[type="date"].form-control,.input-group-lg>input[type="date"].input-group-addon,.input-group-lg>.input-group-btn>input[type="date"].btn,.input-group-lg input[type="date"],input[type="time"].input-lg,.input-group-lg>input[type="time"].form-control,.input-group-lg>input[type="time"].input-group-addon,.input-group-lg>.input-group-btn>input[type="time"].btn,.input-group-lg input[type="time"],input[type="datetime-local"].input-lg,.input-group-lg>input[type="datetime-local"].form-control,.input-group-lg>input[type="datetime-local"].input-group-addon,.input-group-lg>.input-group-btn>input[type="datetime-local"].btn,.input-group-lg input[type="datetime-local"],input[type="month"].input-lg,.input-group-lg>input[type="month"].form-control,.input-group-lg>input[type="month"].input-group-addon,.input-group-lg>.input-group-btn>input[type="month"].btn,.input-group-lg input[type="month"]{line-height:46px;}
}
@media max-device-width480px and orientationlandscape {
.navbar-fixed-top .navbar-collapse,.navbar-fixed-bottom .navbar-collapse{max-height:200px;}
}
@media all and transform-3d,-webkit-transform-3d {
.carousel-inner>.item{-webkit-transition:0 .6s ease-in-out;-moz-transition:0 .6s ease-in-out;-o-transition:0 .6s ease-in-out;transition:transform .6s ease-in-out;-webkit-backface-visibility:hidden;-moz-backface-visibility:hidden;backface-visibility:hidden;-webkit-perspective:1000px;-moz-perspective:1000px;perspective:1000px;}
.carousel-inner>.item.next,.carousel-inner>.item.active.right{-webkit-transform:translate3d(100%,0,0);transform:translate3d(100%,0,0);left:0;}
.carousel-inner>.item.prev,.carousel-inner>.item.active.left{-webkit-transform:translate3d(-100%,0,0);transform:translate3d(-100%,0,0);left:0;}
.carousel-inner>.item.next.left,.carousel-inner>.item.prev.right,.carousel-inner>.item.active{-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0);left:0;}
}
@media screen and min-width768px {
.carousel-control .glyphicon-chevron-left,.carousel-control .glyphicon-chevron-right,.carousel-control .icon-prev,.carousel-control .icon-next{width:30px;height:30px;margin-top:-10px;font-size:30px;}
.carousel-control .glyphicon-chevron-left,.carousel-control .icon-prev{margin-left:-10px;}
.carousel-control .glyphicon-chevron-right,.carousel-control .icon-next{margin-right:-10px;}
.carousel-caption{left:20%;right:20%;padding-bottom:30px;}
.carousel-indicators{bottom:20px;}
.navbar.container{max-width:720px;}
.top-image .views-field-field-put-title-in-top-image .field-content h1#top-image-title{font-size:3em;}
.top-image:not(.has-subtext) .views-field-field-put-title-in-top-image .field-content h1#top-image-title{margin-top:20px;}
#quote-carousel{margin-bottom:0;padding:0 40px 30px;}
.tab-matrix .container #perpetual .legend{text-align:right;}
.tab-matrix .container #perpetual .legend .circleholder{display:inline-block;text-align:inherit;margin:0;}
}
@media max-width767px {
table.visible-xs{display:table!important;}
tr.visible-xs{display:table-row!important;}
th.visible-xs,td.visible-xs{display:table-cell!important;}
.visible-xs-inline{display:inline!important;}
.visible-xs-inline-block{display:inline-block!important;}
.hidden-xs{display:none!important;}
.visible-xs,.visible-xs-block{display:block!important;}
}
@media min-width768px and max-width991px {
table.visible-sm{display:table!important;}
tr.visible-sm{display:table-row!important;}
th.visible-sm,td.visible-sm{display:table-cell!important;}
.visible-sm-inline{display:inline!important;}
.visible-sm-inline-block{display:inline-block!important;}
.hidden-sm{display:none!important;}
.visible-sm,.visible-sm-block{display:block!important;}
}
@media min-width992px and max-width1199px {
table.visible-md{display:table!important;}
tr.visible-md{display:table-row!important;}
th.visible-md,td.visible-md{display:table-cell!important;}
.visible-md-inline{display:inline!important;}
.visible-md-inline-block{display:inline-block!important;}
.hidden-md{display:none!important;}
.visible-md,.visible-md-block{display:block!important;}
}
@media print {
table.visible-print{display:table!important;}
tr.visible-print{display:table-row!important;}
th.visible-print,td.visible-print{display:table-cell!important;}
.visible-print-inline{display:inline!important;}
.visible-print-inline-block{display:inline-block!important;}
.hidden-print{display:none!important;}
.visible-print,.visible-print-block{display:block!important;}
}

</style>
There are lots of powerful things you can do with the Markdown editor. If you've gotten pretty comfortable with writing in Markdown, then you may enjoy some more advanced tips about the types of things you can do with Markdown!

As with the last post about the editor, you'll want to be actually editing this post as you read it so that you can see all the Markdown code we're using.


## Special formatting

As well as bold and italics, you can also use some other special formatting in Markdown when the need arises, for example:

+ ~~strike through~~
+ ==highlight==
+ \*escaped characters\*


## Writing code blocks

There are two types of code elements which can be inserted in Markdown, the first is inline, and the other is block. Inline code is formatted by wrapping any word or words in back-ticks, `like this`. Larger snippets of code can be displayed across multiple lines using triple back ticks:

```
.my-link {
    text-decoration: underline;
}
```

#### HTML

<p>
<table class="table-narrow">
	<thead>
		<tr>
			<th>Features</th>
			<th>Azure Load Balancer</th>
			<th>Azure Application Gateway</th>
			<th>Azure Traffic Manager</th>
			<th>LoadMaster for Azure</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Basic and Standard Tier VM support</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Network Level L4 load balancing</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Multiple application access with single IP</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Pre-configured application templates</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Web User Interface for ease of management</td>
			<td>Limited</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>High Availability &amp; Clustering</td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Web Application Firewall</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Hybrid Traffic Distribution</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Scheduling methods</td>
			<td>Round Robin Only</td>
			<td>Round Robin</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td>Multiple</td>
		</tr>
		<tr>
			<td>Server Persistance</td>
			<td>IP Address</td>
			<td>IP Address Cookies</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td>Multiple</td>
		</tr>
		<tr>
			<td>SSL Termination/Offload</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Content Caching/Compression</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Least Connection Scheduling</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Server Name Indicator (SNI)</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>VM Availability Awareness</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Two Factor Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Health Check Aggregation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Single Sign On</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>SmartCard(CAC) / X.509 Certificate Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>LDAP Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Radius Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Kerberos Constrained Delegation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>AD group based traffic steering</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Header content switching</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td>Limited</td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Header manipulation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Content Rewriting</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Adaptive scheduling</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>OCSP Certificate Validation</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>SAML Authentication</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>HTTP/2 Support</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
		<tr>
			<td>Reverse Proxy</td>
			<td><i class="ka table-cross">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
			<td><i class="ka table-check">&zwnj;</i></td>
		</tr>
	</tbody>
</table>
</p>

#### CSS

```css
.highlight .c {
    color: #999988;
    font-style: italic; 
}
.highlight .err {
    color: #a61717;
    background-color: #e3d2d2; 
}
```

#### JS

```js
// alertbar later
$(document).scroll(function () {
    var y = $(this).scrollTop();
    if (y > 280) {
        $('.alertbar').fadeIn();
    } else {
        $('.alertbar').fadeOut();
    }
});
```

#### Python

```python
print("Hello World")
```

#### Ruby

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### C

```c
printf("Hello World");
```




![walking]({{ site.baseurl }}/assets/images/8.jpg)

## Reference lists

The quick brown jumped over the lazy.

Another way to insert links in markdown is using reference lists. You might want to use this style of linking to cite reference material in a Wikipedia-style. All of the links are listed at the end of the document, so you can maintain full separation between content and its source or reference.

## Full HTML

Perhaps the best part of Markdown is that you're never limited to just Markdown. You can write HTML directly in the Markdown editor and it will just work as HTML usually does. No limits! Here's a standard YouTube embed code as an example:

<p><iframe style="width:100%;" height="315" src="https://www.youtube.com/embed/Cniqsc9QfDo?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe></p>
