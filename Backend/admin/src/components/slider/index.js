import React from 'react';
import { Slider } from 'antd';

const IntegerStep = (props) => {
  const { options, onChange, value, min, max, name } = props;

  return (
    <Slider
      name={name}
      min={min}
      max={max}
      onChange={onChange}
      value={typeof value === 'number' ? value : 0}
      marks={options}
    />
  );
};

export default IntegerStep;
