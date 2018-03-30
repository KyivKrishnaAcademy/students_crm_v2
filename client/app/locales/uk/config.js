export default {
  rtl: false,

  pluralForm: function(count) {
    if (count === 0) { return 'zero'; }
    if (count === 1) { return 'one'; }
    if (count === 2) { return 'two'; }
    if (count < 5) { return 'few'; }
    if (count >= 5) { return 'many'; }
    return 'other';
  },
}
