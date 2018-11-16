import React, { Component } from 'react';

import { checkSignIn } from "../utils/auth";
import { getCurrentUser } from "../utils/user";
import { get } from "../utils/request";
import { UserInfo, Stats, MicropostForm, Feed } from "../shared";

class Home extends Component {
  state = {
    feedItems: [],
    microposts: [],
    followings: [],
    followers: [],
    error: ''
  }

  get currentUser() {
    return getCurrentUser();
  }

  async componentDidMount() {
    const isSignedIn = checkSignIn();
    if (isSignedIn) {
      try {
        const microposts = await get(`/users/${this.currentUser.id}/microposts`);
        const followings = await get(`/users/${this.currentUser.id}/followings`);
        const followers = await get(`/users/${this.currentUser.id}/followers`);
        const feedItems = await get(`/users/feed`);
        this.setState({
          microposts,
          followings,
          followers,
          feedItems
        })
      } catch (err) {
        this.setState({
          error: err.message
        })
      }

    }
  }

  reloadFeedItems = async () => {
    const feedItems = await get(`/users/feed`);
    this.setState({
      feedItems
    })
  }

  addToFeed = async (micropost) => {
    try {
      const microposts = await get(`/users/${this.currentUser.id}/microposts`);
      this.setState(prevState => ({
        feedItems: [micropost, ...prevState.feedItems],
        microposts
      }))
    } catch (err) {
      this.setState({
        error: err.message
      })
    }
  }

  render() {
    const { microposts, followings, followers } = this.state;
    const isSignedIn = checkSignIn();
    const currentUser = getCurrentUser();
    return (
      <div className="container">
        {
          isSignedIn && (
            <div className="row">
              <aside className="span4">
                <section>
                  <UserInfo {...{ currentUser, microposts }}/>
                </section>
                <section>
                  <Stats id={currentUser.id} {...{ followings, followers }} />
                </section>
                <section>
                  <MicropostForm handleCreateMicropostSuccess={this.addToFeed} />
                </section>
              </aside>
              <div className="span8">
                <h3>Micropost Feed</h3>
                <Feed feedItems={this.state.feedItems} reloadFeedItems={this.reloadFeedItems} />
              </div>
            </div>
          )
        }
        {
          !isSignedIn && (
            <div className="center hero-unit">
                <h1>Welcome to the Sample App</h1>

                <h2>
                  This is the home page for the
                  <a href="http://railstutorial.org/">Ruby on Rails Tutorial</a>
                  sample application.
                </h2>
                <a href="/signup" className="btn btn-large btn-primary">Sign up now!</a>
              </div>
          )
        }
      </div>
    )
  }
}

export default Home;
