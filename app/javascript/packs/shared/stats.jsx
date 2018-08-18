import React from 'react';
import { Link } from "react-router-dom";

const Stats = ({ followings, followers }) => {
  return (
    <div>
      <div className="stats">
        <Link to="/followings">
          <strong id="followings" className="stat">
            {followings.length} followings
          </strong>
        </Link>
        <Link to="/followers">
          <strong id="followers" className="stat">
            { followers.length} followers
          </strong>
        </Link>
      </div>
    </div>
  );
};

export default Stats;