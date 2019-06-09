import styled, { keyframes } from "styled-components/macro";
import { Link } from "react-router-dom";

const animation = keyframes`
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
`;

export const AppContainer = styled.div`
  text-align: center;
`;

export const Logo = styled.img`
  animation: ${animation} infinite 20s linear;
  height: 40vmin;
  pointer-events: none;
`;

export const Header = styled.header`
  background-color: ${({ color }) => color};
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
  color: white;
`;

export const StyledLink = styled(Link)`
  color: #61dafb;
`;
