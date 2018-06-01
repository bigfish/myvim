import chai, { expect } from 'chai';
import sinon from 'sinon-es6';

import HelpPage from '../../../src/components/pages/HelpPage';
import HelpPageContainer from '../../../src/components/pages/HelpPageContainer';

describe('HelpPageContainer', () => {
  let mocks;
  let connectStub;
  const mockFunnel = {};

  beforeEach(() => {
    connectStub = sinon.stub().returns(cmp => cmp);
    mocks = {
      connect: connectStub
    };
    HelpPageContainer.__Rewire__(mocks);
  });

  afterEach(() => {
    HelpPageContainer.__ResetDependency__(mocks);
  });

  it('should transfer the state to props', () => {
    const connected = HelpPageContainer();
    expect(connected).to.equal(HelpPage);
    const mapStateToProps = connectStub.getCall(0).args[0];
    expect(mapStateToProps({ funnel: mockFunnel }))
      .to.eql({
        funnel: mockFunnel
      });
  });
});
