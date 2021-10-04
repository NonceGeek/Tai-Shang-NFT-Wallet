import { ApolloClient, ApolloProvider, InMemoryCache } from "@apollo/client";
import React, { Component } from 'react';
import LoadingProgress from './hooks/Progress';
import { ThemeSwitcherProvider } from "react-css-theme-switcher";
import ReactDOM from "react-dom";
import App from "./App";
import "./index.css";
// import Loading from "./hooks/Loading"

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

  constructor(props) {
    super(props);
    this.state = {
      loaded: false,
      current: 0,
      total: parseInt(this.getTotalTime() / 0.1)
    };
    console.log(this.networkSpeed());
    console.log(parseInt(this.getTotalTime() / 0.1));
    this.changeProgressBar();

  }

  timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }


  async changeProgressBar() {
    for (let i = 0; i < this.state.total; i++) {
      await this.timeout(100);
      await this.setState({ current: i + 1 });
    }
    this.setState({ loaded: true })
  }

  getLoaded = () => {
    this.props.getLoaded(this.state.loaded)
  }
  //测网速，仅谷歌可用
  networkSpeed = () => {
    return navigator.connection.downlink * 1024 / 8; //单位为KB/sec
  }
  getTotalTime = () => {
    const networkSpeed = this.networkSpeed();
    //时间 = 资源大小/网速
    return (2 * 1024 / networkSpeed)
  }

  render() {
    if (!this.state.loaded) {
      return (
        <div className="loading">
          <div style={{marginTop: '200px'}}>
            <LoadingProgress
              active={true}
              total={this.state.total}
              current={this.state.current}
            />
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <ApolloProvider client={client}>
            <ThemeSwitcherProvider themeMap={themes} defaultTheme={prevTheme || "light"}>
              <App subgraphUri={subgraphUri} />
            </ThemeSwitcherProvider>
          </ApolloProvider>,
        </div>
      )
    }

  }
}

ReactDOM.render(
  <Loading />,
  document.getElementById('root')
)


