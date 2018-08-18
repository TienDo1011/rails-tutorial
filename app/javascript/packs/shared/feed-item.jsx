import React, { Component } from 'react';
import timeAgo from 'time-ago';
import { Link } from "react-router-dom";
import { gravatarFor, getCurrentUser } from '../utils/user';
import { deleteRequest } from "../utils/request";

class FeedItem extends Component {
  handleDeleteItem = async (ev) => {
    ev.preventDefault();
    const { item } = this.props;
    const confirmed = confirm("You sure?");
    if (confirmed) {
      await deleteRequest(`/microposts/${item.id}`);
      this.props.reloadFeedItems();
    }
  }
  render() {
    const currentUser = getCurrentUser();
    const { item } = this.props;
    const isOwner = currentUser.id === item.userId;
    return (
      <li id={item.id} className="feed-item">
        <a><img src={gravatarFor({ email: item.userEmail })} /></a>
        <span class="user">
          <Link to={`/users/${item.userId}`}>{item.userName}</Link>
        </span>
        <span class="content">{item.content}</span>
        <span class="timestamp">
          Posted {timeAgo.ago(item.created_at)}.
        </span>
        {
          isOwner && (
            <a href="#" onClick={this.handleDeleteItem}>Delete</a>
          )
        }
      </li>
    );
  } 
}

export default FeedItem;