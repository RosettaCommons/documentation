// Helpers
function pageName(){
  // "my/dir/file" => "file"
  return typeof(pageFullPath) == 'undefined' ? undefined : pageFullPath.split('/').pop();
}
function pagePath(){
  // "my/dir/file" => "my/dir"
  return typeof(pageFullPath) == 'undefined' ? undefined : pageFullPath.split('/').slice(0,-1).join('/');
}

// Generic HTML escape function
function htmlEscape( str ) {
  // The (slower) alternative is: return $('<div/>').text(str).html();
  // http://stackoverflow.com/questions/1219860/javascript-jquery-html-encoding/7124052#7124052
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

// Given a page name and a current path, returns a fully qualified path.
function abspath(path, name){
  // Make sure the given path starts at the root.
  if(name[0] != '/'){
    name = '/' + name;
    if (path) {
      name = '/' + path + name;
    }
  }
  var name_parts = name.split('/');
  var newPath = name_parts.slice(0, -1).join('/');
  var newName = name_parts.pop();
  // return array of [path, name]
  return [newPath, newName];
}

// ua
$(document).ready(function() {
  $('#delete-link').click( function(e) {
    var ok = confirm($(this).data('confirm'));
    if ( ok ) {
      var loc = baseUrl + '/delete/' + pageFullPath;
      window.location = loc;
    }
    // Don't navigate on cancel.
    e.preventDefault();
  } );

  var nodeSelector = {
    node1: null,
    node2: null,

    selectNodeRange: function( n1, n2 ) {
      if ( nodeSelector.node1 && nodeSelector.node2 ) {
        $('#wiki-history td.selected').removeClass('selected');
        nodeSelector.node1.addClass('selected');
        nodeSelector.node2.addClass('selected');

        // swap the nodes around if they went in reverse
        if ( nodeSelector.nodeComesAfter( nodeSelector.node1,
                                          nodeSelector.node2 ) ) {
          var n = nodeSelector.node1;
          nodeSelector.node1 = nodeSelector.node2;
          nodeSelector.node2 = n;
        }

        var s = true;
        var $nextNode = nodeSelector.node1.next();
        while ( $nextNode ) {
          $nextNode.addClass('selected');
          if ( $nextNode[0] == nodeSelector.node2[0] ) {
            break;
          }
          $nextNode = $nextNode.next();
        }
      }
    },

    nodeComesAfter: function ( n1, n2 ) {
      var s = false;
      $(n1).prevAll().each(function() {
        if ( $(this)[0] == $(n2)[0] ) {
          s = true;
        }
      });
      return s;
    },

    checkNode: function( nodeCheckbox ) {
      var $nodeCheckbox = nodeCheckbox;
      var $node = $(nodeCheckbox).parent().parent();
      // if we're unchecking
      if ( !$nodeCheckbox.is(':checked') ) {

        // remove the range, since we're breaking it
        $('#wiki-history tr.selected').each(function() {
          if ( $(this).find('td.checkbox input').is(':checked') ) {
            return;
          }
          $(this).removeClass('selected');
        });

        // no longer track this
        if ( $node[0] == nodeSelector.node1[0] ) {
          nodeSelector.node1 = null;
          if ( nodeSelector.node2 ) {
            nodeSelector.node1 = nodeSelector.node2;
            nodeSelector.node2 = null;
          }
        } else if ( $node[0] == nodeSelector.node2[0] ) {
          nodeSelector.node2 = null;
        }

      } else {
        if ( !nodeSelector.node1 ) {
          nodeSelector.node1 = $node;
          nodeSelector.node1.addClass('selected');
        } else if ( !nodeSelector.node2 ) {
          // okay, we don't have a node 2 but have a node1
          nodeSelector.node2 = $node;
          nodeSelector.node2.addClass('selected');
          nodeSelector.selectNodeRange( nodeSelector.node1,
                                        nodeSelector.node2 );
        } else {
          // we have two selected already
          $nodeCheckbox[0].checked = false;
        }
      }
    }
  };

  // ua detection
  if ($.browser.mozilla) {
    $('body').addClass('ff');
  } else if ($.browser.webkit) {
    $('body').addClass('webkit');
  } else if ($.browser.msie) {
    $('body').addClass('ie');
    if ($.browser.version == "7.0") {
      $('body').addClass('ie7');
    } else if ($.browser.version == "8.0") {
      $('body').addClass('ie8');
    }
  }

  if ($('#wiki-wrapper').hasClass('history')) {
    $('#wiki-history td.checkbox input').each(function() {
      $(this).click(function() {
        nodeSelector.checkNode($(this));
      });
      if ( $(this).is(':checked') ) {
        nodeSelector.checkNode($(this));
      }
    });

    if ($('.history a.action-compare-revision').length) {
      $('.history a.action-compare-revision').click(function() {
        $("#version-form").submit();
      });
    }
  }

  if( $('#wiki-history').length ){
    var lookup = {};
    $('img.identicon').each(function(index, element){
      var $item   = $(element);
      var code    = parseInt($item.data('identicon'), 10);
      var img_bin = lookup[code];
      if( img_bin === undefined ){
        var size = 16;
        var canvas = $('<canvas width=16 height=16/>').get(0);
        render_identicon(canvas, code, 16);
        img_bin = canvas.toDataURL("image/png");
        lookup[code] = img_bin;
      }
      $item.attr('src', img_bin);
    });
  }
});
