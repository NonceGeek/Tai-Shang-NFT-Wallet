import React from "react";
import nProgress from "nprogress";
import "nprogress/nprogress.css"
class Loading extends React.Component {
    constructor() {
        super();
        nProgress.start()
    }
    render() {
        return (
            <div></div>
        )
    }
}
export default Loading