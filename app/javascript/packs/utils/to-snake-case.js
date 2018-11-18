function toSnakeCase(obj) {
  const snakedCaseObj = {};
  Object.keys(obj).forEach(key => {
    const value = obj[key];
    const snakedCaseKey = key.replace(/[A-Z]/g, x => `_${x.toLowerCase()}`);
    if (typeof value == "object" && value !== null && !Array.isArray(value)) {
      snakedCaseObj[snakedCaseKey] = toSnakeCase(value);
    } else {
      snakedCaseObj[snakedCaseKey] = value;
    }
  });
  return snakedCaseObj;
}

export { toSnakeCase };
