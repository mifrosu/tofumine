// A common Flux implementation uses lots of constants
// These act as a registry of the types of messages our
// application will support. Note this is controversial.
//
const Constants = {
  CHANGE_EVENT: 'change',
  ADD_COMMENT: 'comments.add'
}

// Implement the Store, using a library called lodash (underscore alternative).
// We are going to extend the event emitter prototype:

class Store extends EventEmitter {
  constructor() {
    super();
    this._comments = []
  }

  addComment(comment) {
    this._comments[comment.id] = comment;
  }

  comments() {
    return this._comments;
  }

  // Flux boilerplate (it is the store's responsibility to notify
  // subscribed components of changes. This is done with the following
  // methods) :
  addChangeListener(callback) {
    this.on(Constants.CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.removeListener(Constants.CHANGE_EVENT, callback);
  }

  emitChange() {
    this.emit(Constants.CHANGE_EVENT);
  }

}

let commentStore = new Store();


// Declare our single Dispatcher
var AppDispatcher = new Flux.Dispatcher();

AppDispatcher.register((payload) => {
  switch(payload.actionType) {
    case Constants.ADD_COMMENT:
      commentStore.addComment(payload.comment);
      commentStore.emitChange();    // tell the world there is a change
      break;
    default:
      // NO-OP
  }
});

// Actions

// using lodash to create a new class
class Actions {
  addComment(params) {
    AppDispatcher.dispatch({
      actionType: Constants.ADD_COMMENT,
      comment: params
    });
  }
}

let commentActions = new Actions();
