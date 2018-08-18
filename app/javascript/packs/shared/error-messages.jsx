import React from 'react';
import pluralize from 'pluralize';

const ErrorMessages = ({ errors }) => {
  const hasErrors = errors.length > 0;
  return (
    <div>
      {
        hasErrors && (
          <div id="error_explanation">
            <div class="alert alert-error">
              The form contains {pluralize("error", errors.length)}.
            </div>
            <ul>
              {
                errors.forEach(msg => <li>* {msg} </li>)
              }
            </ul>
          </div>
        )
      }
    </div>
  );
};

export default ErrorMessages;