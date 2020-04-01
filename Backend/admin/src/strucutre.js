const unFlatten = {
  users: {
    userId1: {
      answers: {
        questionId: {
          answer: 1,
        },
        questionId2: {
          answer: 2,
        },
        questionId3: {
          answer: 4,
        },
        questionId4: {
          answer: 3,
        },
      },
    },
    userId2: {
      answers: {
        questionId: {
          answer: 1,
        },
        questionId2: {
          answer: 2,
        },
        questionId3: {
          answer: 4,
        },
        questionId4: {
          answer: 3,
        },
      },
    },
  },
};

console.log(unFlatten);

const structure = {
  users: {
    userId1: {
      email: 'email',
      score: 50,
    },
    userId2: {
      email: 'email',
      score: 20,
    },
    userId3: {
      email: 'email',
      score: 30,
    },
  },
  answers: {
    answerId1: {
      title: 'Bad',
      value: 1,
    },
    answerId2: {
      title: 'Mmm',
      value: 2,
    },
    answerId3: {
      title: 'Ok',
      value: 3,
    },
    answerId4: {
      title: 'Good',
      value: 4,
    },
    answerId5: {
      title: 'Awesome',
      value: 5,
    },
  },
  userAnswers: {
    userId1: {
      questionId1: 2,
      questionId2: 5,
      questionId3: 4,
    },
    userId2: {
      questionId1: 1,
      questionId2: 3,
      questionId3: 2,
    },
  },
  questions: {
    questionId1: {
      title: 'How are u today',
      options: {
        answerId1: 'Bad',
        answerId2: 'Mmm',
        answerId3: 'Ok',
        answerId4: 'Good',
        answerId5: 'Awesome',
      },
    },
    questionId2: {
      title: 'Am avut stari bruste de anxietate',
      options: {
        answerId1: 'Bad',
        answerId2: 'Mmm',
        answerId3: 'Ok',
        answerId4: 'Good',
        answerId5: 'Awesome',
      },
    },
  },
};

console.log(structure);
