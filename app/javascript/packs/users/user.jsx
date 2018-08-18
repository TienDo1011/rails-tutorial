import React, { Component } from 'react';
import axios from 'axios';
import { Link } from "react-router-dom";
import { gravatarFor, getCurrentUser } from '../utils/user';

class User extends Component {
  handleDelete = () => {
    const { user } = this.props;
    const confirmed = confirm('You sure?');
    if (confirmed) {
      axios.delete(`/users/${user.id}`);
    }
  }
  render() {
    const { user } = this.props;
    const currentUser = getCurrentUser();
    const isAdmin = currentUser.admin === true;
    const isCurrentUser = currentUser.id === user.id;
    return (
      <li>
        <img src={gravatarFor(user, { size: 52 })}/>
        <Link to={`/users/${user.id}`}>{user.name}</Link>
        {
          isAdmin && !isCurrentUser && 
            <a href="#" onClick={handleDelete}>Delete</a>
        }
      </li>
    );
  }
}

export default User;