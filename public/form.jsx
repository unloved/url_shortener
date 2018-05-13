class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {url: '', items: []};
    this.onSubmit = this.onSubmit.bind(this);
    this.onInputChange = this.onInputChange.bind(this);
  }

  onSubmit(event){
    event.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/api/urls',
      data: {url: this.state.url},
      success: function(response){
        this.setState({url: '', items: [response.url, ...this.state.items]})
      }.bind(this)
    });
  }

  onInputChange(event){
    this.setState({url: event.target.value});
  }

  renderItems(){
    let items = this.state.items.map((item) =>
      <li className="list-group-item">{item}</li>
    );
    return (
      <ul className="list-group">
        {items}
      </ul>
    );
  }

  render() {
    return(
      <form className="form-shortener" onSubmit={this.onSubmit}>
        <h1 className="h3 mb-3 font-weight-normal">Url Shortener</h1>
        <div className="input-group mb-3">
          <input type="text" className="form-control"
                 placeholder="Your original url"
                 onChange={this.onInputChange}
                 value={this.state.url}
          />
            <div className="input-group-append">
              <button className="btn btn-outline-primary" type="submit">SHORTEN</button>
            </div>
        </div>
        {this.renderItems()}
      </form>
    )
  }
}

ReactDOM.render(
  <Form/>,
  document.body
);