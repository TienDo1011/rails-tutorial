import type from "type-detect";

function toCamelCase(obj) {
  obj = obj || {};
  if (type(obj) === "Array") {
    return obj.map(item => toCamelCase(item));
  }
  const camelCaseObj = {};
  const keys = Object.keys(obj);

  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    const camelCaseKey = key.replace(/[-_]([a-z])/g, m => m[1].toUpperCase());
    if (type(obj[key]) === "Object") {
      camelCaseObj[camelCaseKey] = toCamelCase(obj[key]);
    } else {
      camelCaseObj[camelCaseKey] = obj[key];
    }
  }

  return camelCaseObj;
}

export { toCamelCase };
