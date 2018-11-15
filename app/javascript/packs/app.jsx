// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { BrowserRouter as Router, Route, Redirect } from 'react-router-dom';

import md5 from 'blueimp-md5';

import { Footer, Header } from './layouts'
import { Home, Help, About, Contact } from './static-pages'
import { Signin, Signup } from "./auth";
import { checkSignIn } from './utils/auth';

import { Users, ShowUser, EditUser, ShowFollowings, ShowFollowers } from './users';

const PrivateRoute = ({ component: Component, path }) => {
  const isSignedIn = checkSignIn();
  return (
    <Route path={path} render={ props =>
      isSignedIn ?
        <Component match={props.match} /> :
        <Redirect to={{
          pathname: "/signin",
          state: { from: props.history.location.pathname }
        }}
      />}
    />)
}

class Main extends Component {
  state = {
    isSignedIn: false,
    showNavBar: false
  }

  componentDidMount() {
    const isSignedIn = checkSignIn();
    this.setState({
      isSignedIn,
    })
  }

  handleUpdateAuthState = ({ isSignedIn }) => {
    this.setState({
      isSignedIn
    })
  }

  toggleNavBar = () => {
    this.setState({
      showNavBar: !this.state.showNavBar
    })
  }

  resetShowNavBar = () => {
    this.setState({
      showNavBar: false,
    });
  }

  render() {
    const { isSignedIn, showNavBar } = this.state;
    return (
      <Router>
        <div className="container">
          <Header
            isSignedIn={isSignedIn}
            updateAuthState={this.handleUpdateAuthState}
            showNavBar={showNavBar}
            toggleNavBar={this.toggleNavBar}
            resetShowNavBar={this.resetShowNavBar}
          />
          <Route exact path="/" component={Home} />
          <Route exact path="/users" component={Users} />
          <PrivateRoute path="/users/:id" component={ShowUser} />
          <PrivateRoute path="/profile" component={EditUser} />
          <PrivateRoute path="/users/:id/followings" component={ShowFollowings} />
          <PrivateRoute path="/users/:id/followers" component={ShowFollowers} />
          <Route path="/help" component={Help} />
          <Route path="/about" component={About} />
          <Route path="/contact" component={Contact} />
          <Route path="/signin" render={() => <Signin updateAuthState={this.handleUpdateAuthState}/>} />
          <Route path="/signup" render={() => <Signup updateAuthState={this.handleUpdateAuthState}/>} />
          <Footer />
        </div>
      </Router>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Main />,
    document.body.appendChild(document.createElement('div')),
  )
})
