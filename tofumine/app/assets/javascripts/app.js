// A common Flux implementation uses lots of constants
// These act as a registry of the types of messages our
// application will support. Note this is controversial.
//
var Contstants = {
  CHANGE_EVENT: 'change',
  ADD_COMMENT: 'comments.add'
}

// Implement the Store, using a library called lodash (underscore alternative).
// We are going to extend the event emitter prototype:

var Store = new _.extend({}, EventEmitter.prototype, {
  _comments: [],

  addComment: function(comment) {
    this._comments[comment.id] = comment;
  },

  comments: function() {
    return this._comments;
  },

  // Flux boilerplate :
  addChangeListener: function(callback) {
    this.on(Contstants.CHANGE_EVENT, callback);
  },

  removeChangeListener: function(callback) {
    this.removeListener(Constants.CHANGE_EVENT, callback);
  },

  emitChange: function() {
    this.emit(Constants.CHANGE_EVENT);
  }

});

// Declare our single Dispatcher
var AppDispatcher = new FluxDispatcher();

AppDispatcher.register(function(payload) {
  var action = payload.actionType;
  switch(action) {
    case Constants.ADD_COMMENT:
      Store.addComment(payload.comment);
      break;
    default:
      // NO-OP
  }
});
