import React, { Component } from "react";
import PropTypes from 'prop-types';

import "../themes/progress.css";

class Progress extends Component {
  constructor(props) {
    super(props);
    this.state = {
      startTime: Date.now(),
      currentItem: 0,
      currentTime: null,
      totalItems: 1,
      estimatedLeft: null,
      percentage: "",
      percentageNumber: 0,
      timeElapsed: 0
    };
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.current !== prevState.currentItem) {
      // check if item was updated
      var newState = {};
      if (nextProps.current === 1) {
        newState = {
          startTime: Date.now(),
          currentTime: Date.now(),
          currentItem: 1,
          totalItems: nextProps.total
        };
      } else if (nextProps.current > 1) {
        let delta = Math.abs(Date.now() - prevState.currentTime);
        let timeElapsed = prevState.timeElapsed + delta;
        let averageTimePerItem = timeElapsed / 1000 / nextProps.current;
        let percentageDec = (
          nextProps.current *
          100 /
          prevState.totalItems
        ).toFixed(1);
        let percentage = `${percentageDec}%`;
        delta = averageTimePerItem * (prevState.totalItems - nextProps.current);

        // calculate (and subtract) whole days
        let days = Math.floor(delta / 86400);
        delta -= days * 86400;
        // calculate (and subtract) whole hours
        let hours = Math.floor(delta / 3600) % 24;
        delta -= hours * 3600;
        // calculate (and subtract) whole minutes
        let minutes = Math.floor(delta / 60) % 60;
        delta -= minutes * 60;
        // what's left is seconds
        let seconds = Math.floor(delta % 60); // in theory the modulus is not required
        let formattedDays = "";
        if (days > 0) formattedDays = ("0" + days).slice(-2) + ":";

        let formattedHours = ("0" + hours).slice(-2);
        let formattedMin = ("0" + minutes).slice(-2);
        let formattedSec = ("0" + seconds).slice(-2);
        var estimatedLeft = `${formattedDays}${formattedHours}:${formattedMin}:${formattedSec}`;
        newState = {
          currentTime: Date.now(),
          currentItem: nextProps.current,
          totalItems: nextProps.total,
          estimatedLeft: estimatedLeft,
          percentage: percentage,
          percentageNumber: percentageDec,
          timeElapsed: timeElapsed
        };
      }
      return newState;
    }
    return null;
  }

  render() {
    if (this.props.active) {

      if(this.props.showCompact !== undefined){
        return this.renderSingleLine();
      }
      else{
        return (
          <div className="progressBar">
            

            {this.renderCustomTitle()}
            {this.renderProcessingRequest()}
            
            {this.renderQtyProcessed()}
            
            {this.renderProgressBar()}
            {this.renderTimeRemaining()}
            
            
          </div>
        );
      }
    } else {
      return null;
    }
  }

  renderQtyProcessed(){
     if (this.props.hideQtyProcessed !== undefined && this.props.visualOnly === undefined) {
      return (
          <label>
            {this.props.current} out of {this.props.total} processed
          </label>
        );
    } else {
      return null;
    }
  }

  renderTimeRemaining() {
    if (this.props.hideTimeRemaining !== undefined && !this.props.visualOnly) {
      return <label>Time remaining: {this.state.estimatedLeft}</label>;
    } else {
      return null;
    }
  }

  renderProgressBar() {
    if (this.props.hideProgressBar === undefined) {
      if (this.props.useSpinner !== undefined){
        return(<div className="loader"></div>)
      }
      else{
        return (
          <div>
            <progress max="100" value={this.state.percentageNumber} />
            <label>{this.state.percentage}</label>
          </div>
        );
      }
    } else {
      return null;
    }
  }

  renderProcessingRequest() {
    if (this.props.hideProcessingRequest === undefined && this.props.visualOnly === undefined) {
      return (
        <label>
          Processing your requests, please wait... {this.state.percentage}
        </label>
      );
    } else {
      return null;
    }
  }

  renderTimeRemaining() {
    if (this.props.hideTimeRemaining === undefined && this.props.visualOnly === undefined) {
      return <label>Time remaining: {this.state.estimatedLeft}</label>;
    } else {
      return null;
    }
  }

  renderCustomTitle() {
    if (this.props.showCustomTitle) {
      return <label>{this.state.title}</label>;
    } else {
      return null;
    }
  }

  renderSingleLine(){
    return (
      <div>
        <progress style={this.props.progressBarStyle} max="100" value={this.state.percentageNumber} />
        <label>{this.state.percentage} (Est. Time remaining: {this.state.estimatedLeft})</label>
      </div>
    );   
  }
}




Progress.propTypes = {
  total: PropTypes.number.isRequired,
  active:   PropTypes.bool.isRequired,
  current: PropTypes.number.isRequired,
  showCompact:PropTypes.bool,
  title:PropTypes.string,
  hideProcessingRequest:PropTypes.bool,
  hideTimeRemaining:PropTypes.bool,
  hideProgressBar:PropTypes.bool,
  hideQtyProcessed:PropTypes.bool,
  useSpinner:PropTypes.bool,
  visualOnly:PropTypes.bool
};

export default Progress;
