import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { get } from "../utils/request";
import { gravatarFor } from '../utils/user';
import { Stats, Micropost } from '../shared';
import { checkSignIn } from '../utils/auth';
import FollowForm from "./follow-form"

class View extends Component {
  state = {
    user: null,
  }
  componentDidMount() {
    this.fetchUser();
  }

  fetchUser = () => {
    const { match } = this.props;
    get(`/users/${match.params.id}`)
      .then(user => this.setState({ user }));
  }

  render() {
    const { user } = this.state;
    if (!user) {
      return null;
    }
    const hasMicroposts = user && user.microposts.length > 0;
    const isSignedIn = checkSignIn();
    return (
      <div>
        <div className="row">
          <aside className="span4">
            <section>
              <h1>
              <img src={gravatarFor(user)}/>
              { user.name }
              </h1>
            </section>
            <section>
              <Stats {...user}/>
            </section>
          </aside>
          <div className="span8">
            {
              isSignedIn && <FollowForm userId={user.id} fetchUser={this.fetchUser} />
            }
            {
              hasMicroposts && (
                <div>
                  <h3>Microposts ({ user.microposts.length })</h3>
                  <ol className="microposts">
                    {
                      user.microposts.map(micropost => <Micropost micropost={micropost} user={user} />)
                    }
                  </ol>
                </div>
              )
            }
          </div>
        </div>
      </div>
    );
  }
}

View.propTypes = {

};

export default View;
