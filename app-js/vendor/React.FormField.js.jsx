(() => {
  // wrap your bootstrap form inputs with <React.FormField fieldKey={} errors={}>
  class FormField extends React.Component {
    constructor(props) {
      super(props);
      this.state = {}
    }

    render() {
      var classNames = ["form-group", this.props.className || ""];
      if(this.hasError()) {
        classNames.push("has-error")
      }
      return (
        <div className={_(classNames).unique().compact().value().join(" ")}>
          {this.props.children}
          {this.renderErrors()}
        </div>
      )
    }

    hasError() {
      return !!this.fieldErrors();
    }

    renderErrors() {
      var fieldErrors = this.fieldErrors();
      if(!fieldErrors){return};

      // wrap array
      if(!_.isArray(fieldErrors)) { fieldErrors = [fieldErrors] }

      return (
        <span className="help-block">
          {fieldErrors.join(", ")}
        </span>
      )
    }

    fieldErrors() {
      var errors = this.props.errors || {};
      var fieldKey = this.props.fieldKey || "";
      return errors[fieldKey]
    }
  }

  FormField.propTypes = {
  }

  React.FormField = FormField;
})()
