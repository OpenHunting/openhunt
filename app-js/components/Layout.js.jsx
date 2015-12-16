// app container that holds the state
(() => {
  window.App = window.App || {};

  class Layout extends React.Component {
    constructor(props) {
      super(props);
      this.state = {}
    }

    render() {
      var pageComponent = App[this.props.page];
      if(!pageComponent) {
        console.error("Unable to find component for: ", this.props.page);
      }
      var pageInstance = React.createElement(pageComponent, this.props)

      return (
        <div>{pageInstance}</div>
      )
    }
  }
  Layout.propTypes = {
    page: React.PropTypes.string.isRequired
  };
  App.Layout = Layout;
})()
