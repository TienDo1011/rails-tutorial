import React, { Component } from 'react';
import { deleteRequest } from './../utils/request';
import { Link } from "react-router-dom";
import { gravatarFor, getCurrentUser } from '../utils/user';

class User extends Component {
  handleDelete = () => {
    const { user } = this.props;
    const confirmed = confirm('You sure?');
    if (confirmed) {
      deleteRequest(`/users/${user.id}`);
    }
  }
  render() {
    const { user } = this.props;
    const currentUser = getCurrentUser();
    const isAdmin = currentUser.admin === true;
    const isCurrentUser = currentUser.id === user.id;
    return (
      <li id={user.id}>
        <img src={gravatarFor(user, { size: 52 })}/>
        <Link to={`/users/${user.id}`}>{user.name}</Link>
        {
          isAdmin && !isCurrentUser &&
            <a href="javascript:void(0);" onClick={this.handleDelete}>Delete</a>
        }
      </li>
    );
  }
}

export default User;
