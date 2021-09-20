import axios from "axios"; 

export default async function parseNFT(payload, url) {
  let resp;
  await axios({
    method: 'post',
    url: url,
    data: {
      token_uri: "string: data:application/json;base64,eyJuYW1lIjogIk4gIzIwIiwgImRlc2NyaXB0aW9uIjogIk4gaXMganVzdCBudW1iZXJzLiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGMzUjViR1UrTG1KaGMyVWdleUJtYVd4c09pQjNhR2wwWlRzZ1ptOXVkQzFtWVcxcGJIazZJSE5sY21sbU95Qm1iMjUwTFhOcGVtVTZJREUwY0hnN0lIMDhMM04wZVd4bFBqeHlaV04wSUhkcFpIUm9QU0l4TURBbElpQm9aV2xuYUhROUlqRXdNQ1VpSUdacGJHdzlJbUpzWVdOcklpQXZQangwWlhoMElIZzlJakV3SWlCNVBTSXlNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBqWThMM1JsZUhRK1BIUmxlSFFnZUQwaU1UQWlJSGs5SWpRd0lpQmpiR0Z6Y3owaVltRnpaU0krTmp3dmRHVjRkRDQ4ZEdWNGRDQjRQU0l4TUNJZ2VUMGlOakFpSUdOc1lYTnpQU0ppWVhObElqNHhQQzkwWlhoMFBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJNE1DSWdZMnhoYzNNOUltSmhjMlVpUGpJOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJakV3TUNJZ1kyeGhjM005SW1KaGMyVWlQakU4TDNSbGVIUStQSFJsZUhRZ2VEMGlNVEFpSUhrOUlqRXlNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBqYzhMM1JsZUhRK1BIUmxlSFFnZUQwaU1UQWlJSGs5SWpFME1DSWdZMnhoYzNNOUltSmhjMlVpUGpJOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJakUyTUNJZ1kyeGhjM005SW1KaGMyVWlQamM4TDNSbGVIUStQQzl6ZG1jKyJ9"
    },
    headers: {
        'Content-Type': 'application/json'
    }
  })
  .then(response => {
    resp = response.data.result.image;
    console.log(resp);
  })
  .catch(error => {
    console.log(error);
  });

  return resp;
  // };
  // const resp = async () => {
  //   if (targetNetwork.hasOwnProperty("gasPrice")) {
  //     setGasPrice(targetNetwork.gasPrice);
  //   } else {
  //     if(navigator.onLine){
  //       axios
  //         .get("https://ethgasstation.info/json/ethgasAPI.json")
  //         .then(response => {
  //           const newGasPrice = response.data[speed || "fast"] * 100000000;
  //           if (newGasPrice !== gasPrice) {
  //             setGasPrice(newGasPrice);
  //           }
  //         })
  //         .catch(error => console.log(error));
  //     }
  //   }
  // };

  // return resp;
}
