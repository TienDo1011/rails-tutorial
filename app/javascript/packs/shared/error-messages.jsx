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
              <ul>
                {
                  errors.map((msg, index) => <li key={index}>{msg}</li>)
                }
              </ul>
            </div>
          </div>
        )
      }
    </div>
  );
};

export default ErrorMessages;
