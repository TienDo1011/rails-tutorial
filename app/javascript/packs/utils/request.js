import axios from "axios";
import { getCurrentUser } from "./user";
import { toCamelCase } from "./to-camel-case";
import { toSnakeCase } from "./to-snake-case";

const instance = axios.create({
  baseURL: "/api"
})

function post(url, data) {
  const token = getCurrentUser() && getCurrentUser().token;
  instance.defaults.headers.common["Authorization"] = `Bearer ${token}`;
  return instance.post(url, toSnakeCase(data)).then(response => toCamelCase(response.data));
}

function put(url, data) {
  const token = getCurrentUser() && getCurrentUser().token;
  instance.defaults.headers.common["Authorization"] = `Bearer ${token}`;
  return instance.put(url, toSnakeCase(data)).then(response => toCamelCase(response.data));
}

function get(url, data) {
  const token = getCurrentUser() && getCurrentUser().token;
  instance.defaults.headers.common["Authorization"] = `Bearer ${token}`;
  return instance.get(url, { params: toSnakeCase(data) }).then(response => toCamelCase(response.data));
}

function deleteRequest(url) {
  const token = getCurrentUser() && getCurrentUser().token;
  instance.defaults.headers.common["Authorization"] = `Bearer ${token}`;
  return instance.delete(url).then(response => toCamelCase(response.data));
}

export { get, post, put, deleteRequest };
