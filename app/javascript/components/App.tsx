import * as React from "react";
import * as ReactDOM from "react-dom";

interface AppProps {
    arg: string;
}



const App = ({arg}: AppProps) => {

  const something = <h1>hihihih</h1>;

  return (
    <div>
      <p>{`Hello, ${arg}!`}</p>
      {something}
    </div>
  );
}

export default App;