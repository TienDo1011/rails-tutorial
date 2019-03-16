import React, { Component } from 'react';
import { getCurrentUser } from "../utils/user";
import { post } from "../utils/request";

class MicropostForm extends Component {
  state = {
    micropost: "",
    error: ""
  }

  handleChange = (ev) => {
    this.setState({
      micropost: ev.target.value
    })
  }

  handleSubmit = (ev) => {
    const currentUser = getCurrentUser();
    ev.preventDefault();
    post("/microposts", {
      content: this.state.micropost
    })
    .then(micropost => {
      this.props.handleCreateMicropostSuccess({
        ...micropost,
        userName: currentUser.name,
        userEmail: currentUser.email
      });
      this.setState({
        micropost: "",
      });
    })
    .catch(err => this.setState({
      error: err.message
    }))
  }

  render() {
    const { error } = this.state;
    return (
      <div>
        { error && <div className="alert alert-danger">{error}</div> }
        <form onSubmit={this.handleSubmit}>
          <div className="form-group">
            <textarea
              id="micropost-content"
              value={this.state.micropost}
              onChange={this.handleChange}
              placeholder="Compose new micropost..."
            />
          </div>
        <button type="submit" className="btn btn-large btn-primary">Post</button>
        </form>
      </div>
    );
  }
}

export default MicropostForm;
