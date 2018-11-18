import React, { Component } from 'react';
import axios from "axios";
import { ErrorMessages } from "../shared";

class View extends Component {
  state = {
    name: "",
    email: "",
    password: "",
    passwordConfirmation: "",
    errors: null
  }

  componentDidMount() {
    this.setState({
      name: currentUser.name,
      email: currentUser.email
    })
  }

  handleSubmit = () => {
    axios
      .post(`/users`, this.state)
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
      passwordConfirmation,
      errors
    } = this.state;
    return (
      <div>
        <h1>Sign up</h1>
          <div className="row">
            <div className="span6 offset3">
              <form onSubmit={this.handleSubmit}>
                <ErrorMessages errors={errors} />
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
                  <label htmlFor="passwordConfirmation">Confirm Password</label>
                  <input id="passwordConfirmation" type="text" value={passwordConfirmation} className="form-control" onChange={this.handleChange} />
                </div>
                <button type="submit" className="btn btn-large btn-primary">Create my account</button>
              </form>
            </div>
          </div>
      </div>
    );
  }
}

View.propTypes = {

};

export default View;
