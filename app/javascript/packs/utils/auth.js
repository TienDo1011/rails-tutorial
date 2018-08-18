function checkSignIn() {
  return !!localStorage.getItem('user');
}

export { checkSignIn };