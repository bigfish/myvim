const expect = require('chai').expect;
const session1 = require('../../../../../fixtures/session-1.json');
const session2 = require('../../../../../fixtures/session-2.json');
const session3 = require('../../../../../fixtures/session-3.json');
const session4 = require('../../../../../fixtures/session-4.json');
const couchdb = require('couchdb-promises')();
const helpers = require('../../../../helpers.js');

const COUCHDB = helpers.COUCHDB;
const setupDB = helpers.setupDB;

describe('domReady - map', () => {
  beforeEach(done => {
    setupDB().then(() => {
      couchdb.createBulkDocuments(COUCHDB, 'sessions', [
        session1, session2, session3, session4
      ]).then(() => {
        done();
      });
    }).catch(e => {
      done(e);
    });
  });

  it('should emit the domReady values', done => {
    couchdb.getView(COUCHDB, 'sessions', 'session', 'domReady', { reduce: false, descending: true })
      .then(result => {
        const results = result.data.rows;
        // console.log(JSON.stringify(results, null, '  '));
        expect(results).to.eql([
          {
            id: '2017-02-07T21:31:57.343Z',
            key: 'domReady',
            value: 129
          },
          {
            id: '2017-02-07T21:31:56.411Z',
            key: 'domReady',
            value: 18
          },
          {
            id: '2017-02-07T21:31:28.970Z',
            key: 'domReady',
            value: 114
          },
          {
            id: '2017-02-07T21:31:05.053Z',
            key: 'domReady',
            value: 130
          }
        ]);
        done();
      });
  });
});
