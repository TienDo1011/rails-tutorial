import React from 'react';
import { Link } from "react-router-dom";

const Footer = () => (
  <footer className="footer">
    <small><a href="#">Itter app</a> by Tien Do</small>
    <nav>
      <ul>
        <li><Link to="/about">About</Link></li>
        <li><Link to="/contact">Contact</Link></li>
      </ul>
    </nav>
  </footer>
)

export default Footer;