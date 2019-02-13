import { helper } from '@ember/component/helper';

export function increment([target, step]) {
  return target + (step || 1);
}

export default helper(increment);
