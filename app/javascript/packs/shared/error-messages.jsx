import React from 'react';
import pluralize from 'pluralize';

const ErrorMessages = ({ errors }) => {
  const hasErrors = errors.length > 0;
  return (
    <div>
      {
        hasErrors && (
          <div id="errorExplanation">
            <div className="alert alert-danger">
              The form contains {pluralize("error", errors.length)}.
            </div>
            <ul>
              {
                errors.map(msg => <li>* {msg} </li>)
              }
            </ul>
          </div>
        )
      }
    </div>
  );
};

export default ErrorMessages;
