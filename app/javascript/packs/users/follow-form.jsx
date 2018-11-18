import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { get, post } from "../utils/request";
import { getCurrentUser } from '../utils/user';

class View extends Component {
  state = {
    followings: []
  }

  componentDidMount() {
    get(`/users/${this.currentUser.id}/followings`)
      .then(followings => this.setState({ followings }) )
  }

  unfollow = () => {
    post(`/users/unfollow`, { id: this.props.userId })
      .then(() => {
        get(`/users/${this.currentUser.id}/followings`)
          .then(followings => {
            this.setState({ followings })
            this.props.fetchUser();
          })
      })
  }

  follow = () => {
    post(`/users/follow`, { id: this.props.userId })
      .then(() => {
        get(`/users/${this.currentUser.id}/followings`)
          .then(followings => {
            this.setState({ followings })
            this.props.fetchUser();
          })
      })
  }

  get currentUser() {
    return getCurrentUser();
  }

  render() {
    const { userId } = this.props;
    const isCurrentUser = this.currentUser.id === userId;
    const isFollowing = this.state.followings.some(u => u.id === userId);
    return (
      <div>
        { !isCurrentUser && (
          <div id="followForm">
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
