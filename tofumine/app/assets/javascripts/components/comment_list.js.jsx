var CommentList = React.createClass({

  // component constructor
  componentDidMount: function() {
    commentStore.addChangeListener(this._onChange);
  },

  // component destructor
  componentWillUnmount: function() {
    commentStore.removeChangeListener(this._onChange);
  },

  render: function() {
    console.log("rendering ...");
    return (
      <div>
        {commentStore.comments().map(function(comment) {
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
