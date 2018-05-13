class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {items: ['test1', 'test2']}
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
      <form className="form-shortener">
        <h1 className="h3 mb-3 font-weight-normal">Url Shortener</h1>
        <div className="input-group mb-3">
          <input type="text" className="form-control" placeholder="Your original url"/>
            <div className="input-group-append">
              <button className="btn btn-outline-primary" type="button">SHORTEN</button>
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