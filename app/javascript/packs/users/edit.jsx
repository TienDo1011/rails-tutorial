import React, { Component } from 'react';
import axios from "axios";
import { ErrorMessages } from "../shared";
import { gravatarFor, getCurrentUser } from "../utils/user";

class View extends Component {
  state = {
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
    errors: null
  }

  componentDidMount() {
    const currentUser = getCurrentUser();
    this.setState({
      name: currentUser.name,
      email: currentUser.email
    })
  }

  handleSubmit = () => {
    const currentUser = getCurrentUser();
    axios
      .put(`/users/${currentUser.id}`, this.state)
      .catch(errors => this.setState({errors}));
  }

  handleChange = (ev) => {
    this.setState({
      [ev.target.id]: ev.target.value
    });
  }
  render() {
    const {
      name,
      email,
      password,
      password_confirmation,
      errors
    } = this.state;
    const currentUser = getCurrentUser();
    return (
      <div className="container">
        <h1>Update your profile</h1>
          <div className="row">
            <div className="span6 offset3">
              <form onSubmit={this.handleSubmit}>
                {errors && <ErrorMessages errors={errors} />}
                <div className="form-group">
                  <label htmlFor="name">Name</label>
                  <input id="name" type="text" className="form-control" value={name} onChange={this.handleChange} />
                </div>
                <div className="form-group">
                  <label htmlFor="email">Email</label>
                  <input id="email" type="text" className="form-control" value={email} onChange={this.handleChange} />
                </div>
                <div className="form-group">
                  <label htmlFor="password">Password</label>
                  <input id="password" type="text" className="form-control" value={password} onChange={this.handleChange} />
                </div>
                <div className="form-group">
                  <label htmlFor="password_confirmation">Confirm Password</label>
                  <input id="password_confirmation" type="text" value={password_confirmation} className="form-control" onChange={this.handleChange} />
                </div>
                <button type="submit" className="btn btn-large btn-primary">Save changes</button>
              </form>

              <img src={gravatarFor(currentUser, { size: 52 })}/>
              <a href="http://gravatar.com/emails">change</a>
            </div>
          </div>
      </div>
    );
  }
}

View.propTypes = {

};

export default View;