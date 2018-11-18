import { toSnakeCase } from "../utils/to-snake-case";

describe("camelCase to snakeCase", () => {
  it("transforms", () => {
    const obj = {
      camel: "camel",
      camelCase: "camelCase",
      arr: [1, 2, 3],
      nullKey: null,
      nestedObj: {
        camel: "camel",
        camelCase: "camelCase"
      }
    };
    const snakedCaseObj = toSnakeCase(obj);
    expect(snakedCaseObj).toEqual({
      camel: "camel",
      camel_case: "camelCase",
      arr: [1, 2, 3],
      null_key: null,
      nested_obj: {
        camel: "camel",
        camel_case: "camelCase"
      }
    });
  });
});
