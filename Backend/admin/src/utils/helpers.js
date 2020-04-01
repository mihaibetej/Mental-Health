import formatISO from 'date-fns/formatISO';

export const getDateKey = () => {
  return formatISO(Date.now(), { representation: 'date' });
};
