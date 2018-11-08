import React from 'react';
import { Link } from "react-router-dom";

const Stats = ({ id, followings, followers }) => {
  return (
    <div>
      <div className="stats">
        <Link to={`/users/${id}/followings`}>
          <strong id="followings" className="stat">
            {followings.length} followings
          </strong>
        </Link>
        <Link to={`/users/${id}/followers`}>
          <strong id="followers" className="stat">
            { followers.length} followers
          </strong>
        </Link>
      </div>
    </div>
  );
};

export default Stats;
