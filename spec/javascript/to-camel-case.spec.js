import { toCamelCase } from "../../app/javascript/packs/utils/to-camel-case";

describe("to camel case", () => {
  describe("simple object", () => {
    it("converts", () => {
      const obj = {user_id: 1, user_name: "test"};
      const camelCaseObj = toCamelCase(obj);
      expect(camelCaseObj.userId).toEqual(1)
      expect(camelCaseObj.userName).toEqual("test");
    })
  })

  describe("nested object", () => {
    it("converts", () => {
      const obj = {id: 1, user: {user_id: 1, user_name: "test"}};
      const camelCaseObj = toCamelCase(obj);
      expect(camelCaseObj.id).toEqual(1)
      expect(camelCaseObj.user.userId).toEqual(1);
      expect(camelCaseObj.user.userName).toEqual("test");
    })
  })

  describe("simple object with null value", () => {
    it("converts", () => {
      const obj = {user_id: 1, user_name: null};
      const camelCaseObj = toCamelCase(obj);
      expect(camelCaseObj.userId).toEqual(1)
      expect(camelCaseObj.userName).toEqual(null);
    })
  })

  describe("array of objects", () => {
    it("converts", () => {
      const obj = [{user_id: 1, user_name: "test"}];
      const camelCaseObj = toCamelCase(obj);
      expect(camelCaseObj[0].userId).toEqual(1)
      expect(camelCaseObj[0].userName).toEqual("test");
    })
  })
})