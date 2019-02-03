import Mixin from '@ember/object/mixin';
import { htmlSafe } from '@ember/string';
import { inject as service } from '@ember/service';

export default Mixin.create({
  intl: service(),
  paperToaster: service(),

  unknownServerError(error) {
    if (error.status || error.title) {
      return `${error.status || ''} ${error.title}`;
    } else if (error.detail) {
      return error.detail;
    }

    return JSON.stringify(error);
  },

  errorTexts(error) {
    if (!error.errors) {
      return [this.intl.t('errors.unknownError'), JSON.stringify(error)];
    } else if (error.errors.any(e => e.source)) {
      return [this.intl.t('errors.invalidInput')];
    }

    return [this.intl.t('errors.unknownServerError'), ...error.errors.map(this.unknownServerError)];
  },

  toastAdapterError(error) {
    this.paperToaster.show(htmlSafe(this.errorTexts(error).join('<br>')), { toastClass: 'md-warn', duration: 10000 });
  },
});
