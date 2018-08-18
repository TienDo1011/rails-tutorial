import React, { Component } from 'react';
import timeAgo from 'time-ago';
import axios from 'axios';

class Micropost extends Component {

  handleDelete = (ev) => {
    ev.preventDefault();
    const { micropost } = this.props;
    const confirmed = confirm('You sure?');
    if (confirmed) {
      axios.delete(`/microposts/${micropost.id}`);
    }
  }
  render() {
    const { micropost } = this.props;
    const isOwner = currentUser.id === micropost.id;
    return (
      <div>
        <li>
          <span class="content">{micropost.content}</span>
          <span class="timestamp">
            Posted {timeAgo.ago(micropost.created_at)}.
          </span>
          {
            isOwner && <a href="#" onClick={handleDelete}>Delete</a>
          }
        </li>
      </div>
    );
  }
}

export default Micropost;