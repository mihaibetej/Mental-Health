import formatISO from 'date-fns/formatISO';
import format from 'date-fns/format';

export const getDateKey = () => {
  return formatISO(Date.now(), { representation: 'date' });
};

export const formatDate = (date) => {
  return format(date.toDate(), 'dd MMM yyyy');
};
