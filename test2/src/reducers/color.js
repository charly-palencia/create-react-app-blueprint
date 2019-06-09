import { UPDATE_COLOR } from "../actionTypes";

const initialState = {
  color: "#282c34"
};

export default function authReducer(state = initialState, { type, color }) {
  console.log(type, color);
  switch (type) {
    case UPDATE_COLOR:
      return {
        ...state,
        color
      };
    default:
      return state;
  }
}
