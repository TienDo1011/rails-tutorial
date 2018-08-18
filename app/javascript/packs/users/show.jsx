import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from "axios";
import { gravatarFor } from '../utils/user';
import { Stats, Micropost } from '../shared';
import { checkSignIn } from '../utils/auth';

class View extends Component {
  state = {
    user: null,
  }
  componentDidMount() {
    const { match } = this.props;
    axios
      .get(`/users/${match.params.id}`)
      .then(user => this.setState({ user }));
  }
  render() {
    const { user } = this.state;
    const hasMicroposts = user.micropost.length > 0;
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
              <Stats />
            </section>
          </aside>
          <div className="span8">
            {
              isSignedIn && <FollowForm user={user} />
            }
            {
              hasMicroposts && (
                <div>
                  <h3>Microposts ({ user.microposts.length })</h3>
                  <ol className="microposts">
                    {
                      user.microposts.map(micropost => <Micropost micropost={micopost} />)
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