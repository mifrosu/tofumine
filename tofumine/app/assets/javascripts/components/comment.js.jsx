var Comment = React.createClass({   // create a JS pseudoclass
  propTypes: {                      // attribute to declare expected input
    author: React.PropTypes.string,
    body: React.PropTypes.string,
    rank: React.PropTypes.number
  },

  render: function() {              // this is required
    return(
      <div>
        <div> Author: {this.props.author}</div>
        <div> Body: {this.props.body}</div>
        <div> Rank: {this.props.rank}</div>
      </div>
    );
  }
});
