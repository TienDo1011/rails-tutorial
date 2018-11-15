import React, { Component } from 'react';
import { post } from "../utils/request";
import { Link, withRouter } from "react-router-dom";

class View extends Component {
  state = {
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    error: ''
  }

  updateAuthState = (user) => {
    localStorage.setItem('user', JSON.stringify(user));
    this.props.updateAuthState({
      isSignedIn: true
    })
  }

  handleSignup = async (ev) => {
    ev.preventDefault();
    const { name, email, password, password_confirmation } = this.state;
    try {
      const user = await post("/users/signup", { name, email, password, password_confirmation });
      this.updateAuthState(user);
      this.props.history.push("/");
    } catch (err) {
      this.setState({ error: err.message })
    }
  }

  handleChange = (ev) => {
    this.setState({
      [ev.target.id]: ev.target.value
    })
  }

  render() {
    const { error, name, email, password, password_confirmation } = this.state;
    return (
      <div className="container">
        <h1>Sign up</h1>

        <div className="row">
          <div className="span6 offset3">
            { error && <div className="alert alert-danger">{error}</div> }
            <form onSubmit={this.handleSignup}>
              <div className="form-group">
                <label htmlFor="name">Name</label>
                <input type="text" className="form-control" id="name" value={name} onChange={this.handleChange} />
              </div>
              <div className="form-group">
                <label htmlFor="email">Email</label>
                <input type="text" className="form-control" id="email" value={email} onChange={this.handleChange} />
              </div>
              <div className="form-group">
                <label htmlFor="password">Password</label>
                <input type="password" className="form-control" id="password" value={password} onChange={this.handleChange} />
              </div>
              <div className="form-group">
                <label htmlFor="password_confirmation">Confirmation</label>
                <input type="password" className="form-control" id="password_confirmation" value={password_confirmation} onChange={this.handleChange} />
              </div>

              <button className="btn btn-large btn-primary">Create my account</button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default withRouter(View);
