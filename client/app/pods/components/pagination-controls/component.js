import Component from '@ember/component';
import { computed } from '@ember/object';
import { lte } from '@ember/object/computed';

export default Component.extend({
  classNames: ['pagination-controls layout-row layout-align-center-center'],

  nextPage: computed('pageNumber', function() {
    return this.pageNumber + 1;
  }),

  previousPage: computed('pageNumber', function() {
    return this.pageNumber - 1;
  }),

  lastPage: computed('pageSize', 'total', function() {
    return Math.ceil(this.total / this.pageSize);
  }),

  nextDisabled: computed('pageNumber', function() {
    return this.pageNumber >= this.lastPage;
  }),

  previousDisabled: lte('pageNumber', 1),
});
