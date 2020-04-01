import React from 'react';
import { Slider, Row, Col } from 'antd';

const IntegerStep = (props) => {
  const { options, onChange, value, min, max, name } = props;

  return (
    <Row>
      <Col span={12}>
        <Slider
          name={name}
          min={min}
          max={max}
          onChange={onChange}
          value={typeof value === 'number' ? value : 0}
          marks={options}
        />
      </Col>
    </Row>
  );
};

export default IntegerStep;
