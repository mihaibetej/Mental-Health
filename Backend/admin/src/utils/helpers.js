import formatISO from 'date-fns/formatISO';
import format from 'date-fns/format';

export const getDateKey = (date = Date.now()) => {
  return formatISO(date, { representation: 'date' });
};

export const formatDate = (date) => {
  return format(date.toDate(), 'dd MMM yyyy');
};
