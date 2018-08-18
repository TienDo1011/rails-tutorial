// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { BrowserRouter as Router, Route, Redirect, withRouter } from 'react-router-dom';

import md5 from 'blueimp-md5';

import { Footer, Header } from './layouts'
import { Home, Help, About, Contact } from './static-pages'
import { Signin } from "./auth";
import { checkSignIn } from './utils/auth';

import { Users, EditUser } from './users';

const PrivateRoute = withRouter(({ component: Component, path, history }) => {
  const isSignedIn = checkSignIn();
  return (
    <Route path={path} render={() =>
      isSignedIn ?
        <Component /> :
        <Redirect to={{
          pathname: "/signin",
          state: { from: history.location.pathname }
        }} 
      />}
    />)
})

class Main extends Component {
  state = {
    isSignedIn: false
  }

  componentDidMount() {
    const isSignedIn = checkSignIn();
    this.setState({
      isSignedIn,
    })
  }

  handleUpdateSignIn = ({ isSignedIn }) => {
    this.setState({
      isSignedIn
    })
  }

  render() {
    const { isSignedIn } = this.state;
    return (
      <Router>
        <div>
          <Header isSignedIn={isSignedIn} updateSignIn={this.handleUpdateSignIn} />
          <Route exact path="/" component={Home} />
          <Route exact path="/users" component={Users} />
          <PrivateRoute path="/users/:id/edit" component={EditUser} />
          <Route path="/help" component={Help} />
          <Route path="/about" component={About} />
          <Route path="/contact" component={Contact} />
          <Route path="/signin" render={() => <Signin updateSignIn={this.handleUpdateSignIn}/>} />
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
