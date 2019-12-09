import React, { Component } from 'react';
import './App.scss';
import Header from './components/header/Header';

import { library } from '@fortawesome/fontawesome-svg-core'
import { faCheckCircle, faTrashAlt } from '@fortawesome/free-solid-svg-icons'

library.add(faCheckCircle, faTrashAlt)

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

// class App extends Component {
//   render() {
//     return (
//       <div>
//         <Header/>
//         <Container>
//           <Numbers/>
//         </Container>
//       </div>
//     );
//   }
// }

export default App;
