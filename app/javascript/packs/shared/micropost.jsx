import React, { Component } from 'react';
import timeAgo from 'time-ago';
import { deleteRequest } from 'axios';

class Micropost extends Component {
  handleDelete = (ev) => {
    ev.preventDefault();
    const { micropost } = this.props;
    const confirmed = confirm('You sure?');
    if (confirmed) {
      deleteRequest(`/microposts/${micropost.id}`);
    }
  }
  render() {
    const { micropost, user } = this.props;
    const isOwner = user.id === micropost.user_id;
    return (
      <div>
        <li>
          <span className="content">{micropost.content}</span>
          <span className="timestamp">
            Posted {timeAgo.ago(micropost.created_at)}.
          </span>
          {
            isOwner && <a href="javascript:void(0);" onClick={this.handleDelete}>Delete</a>
          }
        </li>
      </div>
    );
  }
}

export default Micropost;
