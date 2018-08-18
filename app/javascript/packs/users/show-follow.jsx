import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from "react-router-dom";
import { Stats } from "../shared";
import { gravatarFor } from "../utils/user";

class View extends Component {
  state = {
    followings: []
  }
  componentDidMount() {
    axios
      .get(`/users/${currentUser.id}/following`)
      .then(followings => this.setState({ followings }) )
  }

  render() {
    return (
      <div>
        <div className="row">
          <aside className="span4">
            <section>
              <img src={gravatarFor(currentUser)}/>
              <h1>{currentUser.name}</h1>
              <span><Link href="/profile">View my profile</Link></span>
              <span><b>Microposts:</b> {currentUser.microposts.length}</span>
            </section>
            <section>
              <Stats />
              {
                this.state.followings.map(user => (
                  <div className="user_avatars">
                    <img src={gravatarFor(user, { size: 30 })}/>
                  </div>
                ))
              }
            </section>
          </aside>
          <div className="span8">
            <h3>Following</h3>
            { this.state.followings.map(user => (
              <ul className="users">
                <User user={user} />
              </ul>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

View.propTypes = {

};

export default View;