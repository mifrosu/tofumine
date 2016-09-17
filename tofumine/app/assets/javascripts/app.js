// A common Flux implementation uses lots of constants
// These act as a registry of the types of messages our
// application will support. Note this is controversial.
//
var Constants = {
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

  // Flux boilerplate (it is the store's responsibility to notify
  // subscribed components of changes. This is done with the following
  // methods) :
  addChangeListener: function(callback) {
    this.on(Constants.CHANGE_EVENT, callback);
  },

  removeChangeListener: function(callback) {
    this.removeListener(Constants.CHANGE_EVENT, callback);
  },

  emitChange: function() {
    this.emit(Constants.CHANGE_EVENT);
  }

});

// Declare our single Dispatcher
var AppDispatcher = new Flux.Dispatcher();

AppDispatcher.register(function(payload) {
  var action = payload.actionType;
  switch(action) {
    case Constants.ADD_COMMENT:
      Store.addComment(payload.comment);
      Store.emitChange();    // tell the world there is a change
      break;
    default:
      // NO-OP
  }
});

// Actions

// using lodash to create a new class
var Actions = new _.extend({}, {
  addComment: function(params) {
    AppDispatcher.dispatch({
      actionType: Constants.ADD_COMMENT,
      comment: params
    });
  }
});