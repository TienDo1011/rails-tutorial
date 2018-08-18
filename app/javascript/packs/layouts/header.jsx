import React, { Component } from 'react';
import { Link, withRouter} from "react-router-dom";
import { post } from "../utils/request";

class Header extends Component {
  state = {
    openDropdown: false,
    error: ''
  }

  toggleDropdown = () => {
    this.setState(prevState => ({ openDropdown: !prevState.openDropdown }));
  }

  updateAuthState = (user) => {
    localStorage.removeItem('user');
    this.props.updateSignIn({
      isSignedIn: false,
    })
  }

  navigateToHome = () => {
    const { history } = this.props;
    if (history.location.pathname !== "/") {
      history.push("/")
    }
  }

  handleSignout = async () => {
    try {
      await post("/users/signout");
      this.navigateToHome();
      this.updateAuthState();
      this.setState({
        openDropdown: false
      })
    } catch (err) {
      this.setState({ error: err.message })
    }
  }

  render() {
    const { openDropdown, error } = this.state;
    const { isSignedIn } = this.props;
    return (
      <React.Fragment>
        <header className="navbar navbar-fixed-top navbar-inverse">
          <div className="navbar-inner">
            <div className="container">
              <Link to="/" id="logo">Sample App</Link>
              <nav>
                <ul className="nav navbar-nav pull-right">
                  <li><Link to="/">Home</Link></li>
                  <li><Link to="/help">Help</Link></li>
                  {
                    isSignedIn && (
                      <React.Fragment>
                        <li><Link to="/users">Users</Link></li>
                        <li id="fat-menu" className={openDropdown ? "dropdown open" : "dropdown"}>
                          <a href="javascript:void(0);" onClick={this.toggleDropdown} className="dropdown-toggle" data-toggle="dropdown">
                            Account <b className="caret"></b>
                          </a>
                          <ul className="dropdown-menu">
                            <li><Link to="/profile">Profile</Link></li>
                            <li><Link to="/settings">Settings</Link></li>
                            <li className="divider"></li>
                            <li>
                              <a href="javascript:void(0);" onClick={this.handleSignout}>Sign out</a>
                            </li>
                          </ul>
                        </li>
                      </React.Fragment>
                    )
                  }
                  {
                    !isSignedIn && (
                      <li><Link to="/signin">Sign in</Link></li>
                    )
                  }
                </ul>
              </nav>
            </div>
          </div>
        </header>
        { error && <div className="alert alert-danger">{error}</div> }
      </React.Fragment>
    )
  }
}

export default withRouter(Header);