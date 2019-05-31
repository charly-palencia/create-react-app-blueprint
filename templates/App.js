import React from "react";
import { connect } from "react-redux";
import logo from "./logo.svg";
import { fetchColor } from "actions";
import GlobalStyles from "./globalStyles";
import { BrowserRouter as Router, Route } from "react-router-dom";

import Home from "./pages/Home";
import { AppContainer, Logo, Header, StyledLink } from "./components";

function App({ fetchColor, color }) {
  return (
    <AppContainer>
      <GlobalStyles />
      <Router>
        <Header color={color} onClick={fetchColor}>
          <Logo src={logo} alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <StyledLink to="/home">Home page</StyledLink>
          <StyledLink to="/">Index page</StyledLink>

          <Route path="/home" exact component={Home} />
        </Header>
      </Router>
    </AppContainer>
  );
}

function mapStateToProps(state) {
  console.log(state);
  return {
    color: state.color.color
  };
}

const mapDispatchToProps = {
  fetchColor
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App);
