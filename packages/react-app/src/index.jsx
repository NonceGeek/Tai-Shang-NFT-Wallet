import { ApolloClient, ApolloProvider, InMemoryCache } from "@apollo/client";
import React, { Component } from 'react';
import { ThemeSwitcherProvider } from "react-css-theme-switcher";
import ReactDOM from "react-dom";
import App from "./App";
import "./index.css";
import nProgress from "nprogress";
import "nprogress/nprogress.css"

const themes = {
  dark: `${process.env.PUBLIC_URL}/dark-theme.css`,
  light: `${process.env.PUBLIC_URL}/light-theme.css`,
};

const prevTheme = window.localStorage.getItem("theme");

const subgraphUri = "http://localhost:8000/subgraphs/name/scaffold-eth/your-contract";

const client = new ApolloClient({
  uri: subgraphUri,
  cache: new InMemoryCache(),
});


class Loading extends Component {
  constructor() {
    super();
    nProgress.start()
  }
  render(){
      return (
      <div></div>
      )
  }
}
ReactDOM.render(
        <Loading />,
        document.getElementById('root')
      )

function listen(){
  if(document.readyState ==="complete"){
    ReactDOM.render(
      <ApolloProvider client={client}>
            <ThemeSwitcherProvider themeMap={themes} defaultTheme={prevTheme || "light"}>
              <App subgraphUri={subgraphUri} />
            </ThemeSwitcherProvider>
          </ApolloProvider>,
      document.getElementById('root')
    )
  }else{
    ReactDOM.render(
      <Loading />,
      document.getElementById('root')
    )
  }
}

document.onreadystatechange = listen


