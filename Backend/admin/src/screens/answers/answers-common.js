export const calculateRating = (items) =>
  items.reduce((acc, next) => acc + next.answer_value, 0);

export const getDailyStatus = (rating) => {
  if (rating < 11) {
    return 'error';
  }

  if (rating < 22) {
    return 'warning';
  }

  return 'success';
};

export const getQuestionStatus = (value) => {
  if (value < 1) {
    return 'error';
  }

  if (value < 3) {
    return 'warning';
  }

  return 'success';
};

export const getLineColor = (idx) => {
  const colors = {
    0: '#02082d',
    1: '#52839b',
    2: '#0f9e66',
    3: '#3ed718',
    4: '#55c72a',
    5: '#966258',
    6: '#c389be',
    7: '#e25c54',
    8: '#a2b8f3',
    9: '#d2731a',
    10: '#8b835b',
    11: '#f5d141',
  };

  return colors[idx];
};
