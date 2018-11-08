import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from "react-router-dom";
import { Stats } from "../shared";
import { gravatarFor, getCurrentUser } from "../utils/user";
import { get } from "../utils/request"
import User from "./user"

class View extends Component {
  state = {
    followers: []
  }
  componentDidMount() {
    const { id } = this.props.match.params;
    get(`/users/${id}/followers`)
      .then(followers => this.setState({ followers }) )
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className="span8">
            <h3>Followers</h3>
            { this.state.followers.map(user => (
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
