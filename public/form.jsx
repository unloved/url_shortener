class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {original_url: '', strategy:'SecureRandom', items: []};
    this.onSubmit = this.onSubmit.bind(this);
    this.onUrlChange = this.onUrlChange.bind(this);
    this.onStrategyChange = this.onStrategyChange.bind(this);
    this.disabled = this.disabled.bind(this);
  }

  onSubmit(event){
    event.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/api/urls',
      data: {model: {original_url: this.state.original_url, strategy: this.state.strategy}},
      success: function(response){
        this.setState({original_url: '', items: [response, ...this.state.items]})
      }.bind(this),
      error: function(data){
        console.log(data.responseJSON['error']);
        alert(data.responseJSON['error'])
      }.bind(this)
    });
  }

  onUrlChange(event){
    this.setState({original_url: event.target.value});
  }

  onStrategyChange(event){
    this.setState({strategy: event.target.value});
  }

  renderItems(){
    let items = this.state.items.map((item) => {
      let url = window.location.href + item['url'];
      let strategy = item['strategy'];
      return (
      <li className="list-group-item">
        <a href={url} target="_blank">
          {url} ({strategy})
        </a>
        <CopyToClipboard text={url}>
          <button type="button" className="btn btn-secondary btn-sm copy-button">Copy</button>
        </CopyToClipboard>
      </li>
    )}
    );
    return (
      <ul className="list-group">
        {items}
      </ul>
    );
  }


  isUrl(str)
  {
    let regexp = /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
    return regexp.test(str);
  }

  disabled(){
    return !this.isUrl(this.state.original_url)
  }

  render() {
    return(
      <form className="form-shortener" onSubmit={this.onSubmit}>
        <h1 className="h3 mb-3 font-weight-normal">Url Shortener</h1>
        <div className="input-group mb-3">
          <input type="text" className="form-control"
                 placeholder="Your original url"
                 onChange={this.onUrlChange}
                 value={this.state.original_url}
          />
          <select onChange={this.onStrategyChange}>
            <option selected value="SecureRandom">SecureRandom</option>
            <option value="MD5">MD5</option>
            <option value="">any</option>
          </select>
          <div className="input-group-append">
            <button className="btn btn-outline-primary" type="submit" disabled={this.disabled()}>SHORTEN</button>
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