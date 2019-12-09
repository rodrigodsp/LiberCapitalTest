
import React, { Component } from 'react';
import Navbar from 'react-bootstrap/Navbar';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

class Header extends Component {
    render() {
    return (
        <div>
        <Navbar>
            <Navbar.Brand>
            <FontAwesomeIcon icon="abacus" size="lg"/> Identificador de Números Primos - Crivo de Eratóstenes
            </Navbar.Brand>
        </Navbar>
        </div>
    );
    }
}

export default Header;