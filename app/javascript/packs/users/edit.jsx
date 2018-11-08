import React, { Component } from 'react';
import { put } from "../utils/request";
import { ErrorMessages } from "../shared";
import { gravatarFor, getCurrentUser } from "../utils/user";

class View extends Component {
  state = {
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
    errors: null,
    update_success: false
  }

  componentDidMount() {
    const currentUser = getCurrentUser();
    this.setState({
      name: currentUser.name,
      email: currentUser.email
    })
  }

  handleSubmit = (ev) => {
    ev.preventDefault();
    const { name, email, password, password_confirmation } = this.state;
    const currentUser = getCurrentUser();
    const params = {
      id: currentUser.id,
      name,
      email,
      password,
      password_confirmation
    };
    put(`/users/${currentUser.id}`, params)
      .then(user => {
        this.setState({ update_success: true })
        this.hideUpdateSuccess = setTimeout(() => {
          this.setState({ update_success: false })
        }, 5000)
        localStorage.setItem('user', JSON.stringify(user));
      })
      .catch(err => {
        this.setState({ errors: [err.message] })
      });
  }

  handleChange = (ev) => {
    this.setState({
      [ev.target.id]: ev.target.value
    });
  }

  componentWillUnmount() {
    clearTimeout(this.hideUpdateSuccess)
  }

  render() {
    const {
      name,
      email,
      password,
      password_confirmation,
      errors,
      update_success
    } = this.state;
    const currentUser = getCurrentUser();
    return (
      <div className="container">
        <h1>Update your profile</h1>
          <div className="row">
            <div className="span6 offset3">
              <form onSubmit={this.handleSubmit}>
                { update_success && (
                  <div class="alert alert-success">
                    Profile updated
                  </div>
                )}
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
