import React, { Component } from 'react';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

class Numbers extends Component {
    render() {
    return (
        <Row>
            <Col xs={{ span: 8, offset: 2 }} className="numbers_list">
                <p className="title">Números</p>
                <List/>
            </Col>
        </Row>
    );
    }
}

export default Numbers;