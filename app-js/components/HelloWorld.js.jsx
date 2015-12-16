class HelloWorld extends React.Component {

  render() {
    return (
      <div>Hello {this.props.username}</div>
    );
  }
}

window.App = window.App || {};
App.HelloWorld = HelloWorld;
