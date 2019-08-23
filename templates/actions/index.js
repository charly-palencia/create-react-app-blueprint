import { UPDATE_COLOR } from "actionTypes";

const successFetchColor = colorResponse => {
  return {
    type: UPDATE_COLOR,
    color: `#${colorResponse["new_color"]}`
  };
};

export const fetchColor = () => dispatch => {
  fetch("http://www.colr.org/json/color/random")
    .then(response => response.json())
    .then(response => {
      dispatch(successFetchColor(response));
    });
};
