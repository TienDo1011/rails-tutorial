import React, { Component } from 'react';
import { get } from '../utils/request';
import User from './user';

class Users extends Component {
  state = {
    users: [],
    meta: null
  }
  componentDidMount() {
    this.currentPage = 1;
    get('/users')
    .then(({users, meta }) => {
      this.setState({
        users,
        meta
      })
    })
  }

  handlePageClick = (page) => {
    const totalPages = (this.state.meta && this.state.meta.totalPages) || 1;
    if (page < 1 || page > totalPages) return;
    this.currentPage = page;
    get('/users', { page })
    .then(({users}) => {
      this.setState({
        users
      })
    })
  }

  render() {
    const totalPages = (this.state.meta && this.state.meta.totalPages) || 1;
    return (
      <div>
        <h1>All users</h1>
        <ul className="users">
          {this.state.users.map(user => <User key={user.id} user={user} />)}
          {
            (totalPages > 1) && (
              <nav aria-label="Page navigation">
                <ul class="pagination">
                  <li>
                    <a href="javascript:void(0);" aria-label="Previous" onClick={() => this.handlePageClick(this.currentPage - 1)}>
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  {
                    Array(totalPages).fill().map((k, index) => {
                      const page = index + 1;
                      return <li><a href="javascript:void(0);" onClick={() => this.handlePageClick(page)}>{page}</a></li>
                    })
                  }
                  <li>
                    <a href="javascript:void(0);" aria-label="Next" onClick={() => this.handlePageClick(this.currentPage + 1)}>
                      <span aria-hidden="true">&raquo;</span>
                    </a>
                  </li>
                </ul>
              </nav>
            )
          }
        </ul>
      </div>
    );
  }
}

export default Users;
