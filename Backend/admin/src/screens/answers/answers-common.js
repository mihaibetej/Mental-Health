export const calculateRating = (items) =>
  items.reduce((acc, next) => acc + next.answer_value, 0)
