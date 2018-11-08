import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from "react-router-dom";
import { Stats } from "../shared";
import { gravatarFor, getCurrentUser } from "../utils/user";
import { get } from "../utils/request"
import User from "./user"

class View extends Component {
  state = {
    followings: []
  }
  componentDidMount() {
    const { id } = this.props.match.params;
    get(`/users/${id}/followings`)
      .then(followings => this.setState({ followings }) )
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className="span8">
            <h3>Followings</h3>
            { this.state.followings.map(user => (
              <ul key={user.id} className="users">
                <User user={user} />
              </ul>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

View.propTypes = {

};

export default View;
