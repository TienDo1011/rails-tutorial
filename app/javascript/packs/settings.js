import React, { Component, useEffect, useState } from "react";
import { get, put } from "./utils/request";

function View() {
  const [shouldNotify, setShouldNotify] = useState(true);
  useEffect(() => {
    get(`/settings`)
      .then(settings => setShouldNotify(settings.shouldNotify));
  }, [])
  const updateShouldNotify = () => {
    put(`/settings`, { shouldNotify: !shouldNotify })
      .then(settings => setShouldNotify(settings.shouldNotify));
  }

  return (
    <div>
      <h3 className="text-center">Settings</h3>
      <div>
        <h4>Email notification when:</h4>
        <div className="setting-item">
          <div className="setting-item-text">New user has followed me</div>
          <input
            type="checkbox"
            className="setting-item-checkbox"
            checked={shouldNotify}
            onChange={updateShouldNotify}
          />
        </div>
      </div>

    </div>
  )
}

export default View;
