import React from 'react';
import { render } from '@testing-library/react';
import HomePage from './home-page';

test('renders learn react link', () => {
  const { getByText } = render(<HomePage />);
  const text = getByText(/First Page/i);
  expect(text).toBeInTheDocument();
});
