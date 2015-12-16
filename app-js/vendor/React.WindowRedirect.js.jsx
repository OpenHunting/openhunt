(() => {
  class WindowRedirect extends React.Component {
    constructor(props) {
      super(props);
      this.state = {}
    }

    componentDidMount() {
      window.location.href = this.props.url;
    }

    render() {
      return (
        <div>{this.props.children}</div>
      )
    }
  }

  WindowRedirect.propTypes = {
    url: React.PropTypes.string.isRequired
  }

  React.WindowRedirect = WindowRedirect;
})()
