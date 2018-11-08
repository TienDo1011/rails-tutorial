import React, { Component } from 'react';
import { post } from "../utils/request";
import { Link, withRouter } from "react-router-dom";

class View extends Component {
  state = {
    email: '',
    password: '',
    error: ''
  }

  updateAuthState = (user) => {
    localStorage.setItem('user', JSON.stringify(user));
    this.props.updateAuthState({
      isSignedIn: true
    })
  }

  navigateToDesiredPage = () => {
    const { history } = this.props;
    const redirectUrl = history.location.state && history.location.state.from;
    if (!!redirectUrl) {
      history.push(redirectUrl)
    } else {
      if (history.location.pathname !== "/") {
        history.push("/")
      }
    }
  }

  handleSignin = async (ev) => {
    ev.preventDefault();
    const { email, password } = this.state;
    try {
      const user = await post("/users/signin", { email, password });
      this.updateAuthState(user);
      this.navigateToDesiredPage();
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
    const { error, email, password } = this.state;
    return (
      <div className="container">
        <h1>Sign in</h1>

        <div class="row">
          <div class="span6 offset3">
            { error && <div className="alert alert-danger">{error}</div> }
            <form onSubmit={this.handleSignin}>
              <div className="form-group">
                <label htmlFor="email">Email</label>
                <input type="text" className="form-control" id="email" value={email} onChange={this.handleChange} />
              </div>
              <div className="form-group">
                <label htmlFor="password">Password</label>
                <input type="password" className="form-control" id="password" value={password} onChange={this.handleChange} />
              </div>

              <button className="btn btn-large btn-primary">Sign in</button>
            </form>
            <p>New user? <Link to="/signup">Sign up now!</Link></p>
          </div>
        </div>
      </div>
    );
  }
}

export default withRouter(View);
