var CommentList = React.createClass({

  // component constructor
  componentDidMount: function() {
    Store.addChangeListener(this._onChange);
  },

  // component destructor
  componentWillUnmount: function() {
    Store.removeChangeListener(this._onChange);
  },

  render: function() {
    console.log("rendering ...");
    return (
      <div>
        {Store.comments().map(function(comment) {
          return (<Comment key={comment.id} {... comment} />);
        })}
      </div>
    );
  },

  _onChange: function() {
    // tell the component it needs to re-render itself
    this.forceUpdate();
  }
});
