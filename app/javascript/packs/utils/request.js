import axios from "axios";
import { getCurrentUser } from "./user";
import { toCamelCase } from "./to-camel-case";

const instance = axios.create({
  baseURL: "/api"
})

function post(url, data) {
  const rememberToken = getCurrentUser() && getCurrentUser().rememberToken;
  instance.defaults.headers.common["Authorization"] = `Bearer ${rememberToken}`;
  return instance.post(url, data).then(response => toCamelCase(response.data));
}

function get(url, data) {
  const rememberToken = getCurrentUser() && getCurrentUser().rememberToken;
  instance.defaults.headers.common["Authorization"] = `Bearer ${rememberToken}`;
  return instance.get(url, { params: data }).then(response => toCamelCase(response.data));
}

function deleteRequest(url) {
  const rememberToken = getCurrentUser() && getCurrentUser().rememberToken;
  instance.defaults.headers.common["Authorization"] = `Bearer ${rememberToken}`;
  return instance.delete(url).then(response => toCamelCase(response.data));
}

export { get, post, deleteRequest };