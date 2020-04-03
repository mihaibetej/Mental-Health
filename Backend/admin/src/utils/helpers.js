import formatISO from 'date-fns/formatISO';

export const getDateKey = (date = Date.now()) => {
  return formatISO(date, { representation: 'date' });
};
