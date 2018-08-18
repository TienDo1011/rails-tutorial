import React from "react";
import pluralize from 'pluralize';
import { Link } from "react-router-dom";
import { gravatarFor } from "../utils/user";

const UserInfo = ({ currentUser, microposts }) => (
  <div>
    <a href={gravatarFor(currentUser, { size: 52 })} alt={currentUser.name} className="gravatar" ></a>
    <h1>
      { currentUser.name }
    </h1>
    <span>
      <Link to="/profile">View my profile</Link>
    </span>
    <span>
      {
        pluralize("micropost", microposts.length, true)
      }
    </span>
  </div>
)

export default UserInfo;