import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from "axios";

class View extends Component {
  state = {
    followings: []
  }
  componentDidMount() {
    axios
      .get(`/users/${currentUser.id}/following`)
      .then(followings => this.setState({ followings }) )
  }

  unfollow = () => {
    axios
      .post(`/users/unfollow`, { id: this.props.user.id })
      .then(() => {
        axios
          .get(`/users/${currentUser.id}/following`)
          .then(followings => this.setState({ followings }) )
      })
  }

  unfollow = () => {
    axios
      .post(`/users/follow`, { id: this.props.user.id })
      .then(() => {
        axios
          .get(`/users/${currentUser.id}/following`)
          .then(followings => this.setState({ followings }) )
      })
  }
  
  render() {
    const { user } = this.props;
    const isCurrentUser = currentUser.id === user.id;
    const isFollowing = this.state.followings.some(u => u.id === user.id);
    return (
      <div>
        { !isCurrentUser && (
          <div id="follow_form">
          {
            isFollowing && 
              <button className="btn btn-large" onClick={this.unfollow}>Unfollow</button>
          }
          {
            !isFollowing && 
              <button className="btn btn-large btn-primary" onClick={this.follow}>Follow</button>
          }
          </div>
        )}
      </div>
    );
  }
}

View.propTypes = {

};

export default View;