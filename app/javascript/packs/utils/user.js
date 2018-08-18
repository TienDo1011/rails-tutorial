import md5 from 'blueimp-md5';

function gravatarFor(user, options = { size: 50}) {
  const gravatarId = md5(user.email.toLowerCase());
  const size = options.size;
  return `https://secure.gravatar.com/avatar/${gravatarId}?s=${size}`
}

function getCurrentUser() {
  return JSON.parse(localStorage.getItem('user'));
}

export { gravatarFor, getCurrentUser };