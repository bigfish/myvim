/*eslint-disable no-unused-expressions*/
import React from 'react';
import { shallow } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';
import sinon from 'sinon-es6';

import SRC_MODULE_NAME from 'SRC_MODULE_REL_PATH/COMPONENT';

chai.use(chaiEnzyme());

describe('COMPONENT', () => {
  let wrapper;
  let props;

  const getWrapper = testProps => shallow(<COMPONENT {...testProps} />, {
    context: {}
  });

  beforeEach(() => {

    props = {
    };
    wrapper = getWrapper(props);
  });
});
